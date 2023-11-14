//
//  FeatureListViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import UIKit
import RxSwift

class FeatureListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ModelListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Model Yılı"
        setupTableView()
        bindModelViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shared.carInfo.model = nil
        viewModel.fetchModelsData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                let selectedItem = self.viewModel.itemsRelayStringList.value[indexPath.row]
                shared.carInfo.model = selectedItem
                let vc = MakesListViewController(nibName: "MakesListViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindModelViewModel() {
        
        viewModel.isLoading.drive() { isLoading in
            if isLoading {
                self.startLoading()
            } else {
                self.stopLoading()
            }
        }.disposed(by: disposeBag)
        
        viewModel.modelItems
            .drive(tableView.rx.items(cellIdentifier: "CustomTableViewCell", cellType: CustomTableViewCell.self)) { (row, element, cell) in
                cell.configure(title: element)
            }
            .disposed(by: disposeBag)
    }
}
