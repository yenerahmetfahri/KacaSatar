//
//  MakesListViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

class MakesListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = MakesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Marka ve Model"
        setupTableView()
        bindModelViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchMakesData(model: shared.carInfo.model ?? "")
        shared.carInfo.makes = nil
        shared.carInfo.series = nil
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                let selectedItem = self.viewModel.itemsRelayBasicFeature.value[indexPath.row]
                if shared.carInfo.makes == nil {
                    shared.carInfo.makes = selectedItem
                    if let model = shared.carInfo.model, let makeId = shared.carInfo.makes?.id {
                        viewModel.fetchSeriesData(model: model, makeId: "\(makeId)")
                    }
                } else if shared.carInfo.series == nil {
                    shared.carInfo.series = selectedItem
                    let vc = TrimsListViewController(nibName: "TrimsListViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
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
        
        viewModel.basicFeatureItems
            .drive(tableView.rx.items(cellIdentifier: "CustomTableViewCell", cellType: CustomTableViewCell.self)) { (row, element, cell) in
                if let name = element.name {
                    cell.configure(title: name)
                }
            }
            .disposed(by: disposeBag)
    }
    
}
