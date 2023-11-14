//
//  ColorViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import UIKit

class ColorViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ColorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Renk"
        setupTableView()
        bindModelViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchColorData()
    }
}

//MARK: - Auxilary Methods
extension ColorViewController {
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                let selectedItem = self.viewModel.itemsRelayColor.value[indexPath.row]
                shared.carInfo.color = selectedItem
                let vc = KilometrageViewController(nibName: "KilometrageViewController", bundle: nil)
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
        
        viewModel.colorItems
            .drive(tableView.rx.items(cellIdentifier: "CustomTableViewCell", cellType: CustomTableViewCell.self)) { (row, element, cell) in
                if let name = element.name {
                    cell.configure(title: name)
                }
            }
            .disposed(by: disposeBag)
    }
}
