//
//  ChooseTrimViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 12.11.2023.
//

import UIKit

class ChooseTrimViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ChooseTrimViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Paket"
        setupTableView()
        bindModelViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let carInfo = shared.carInfo
        if let model = carInfo.model, let makeId = carInfo.makes?.id, let serieId = carInfo.series?.id {
            viewModel.fetchTrimsData(model: model, makeId: String(makeId), serieId: String(serieId), completion: { result in
                switch result {
                case .success(_):
                    break
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}

//MARK: - Auxilary Methods
extension ChooseTrimViewController {
    private func setupTableView() {
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                let selectedItem = self.viewModel.itemsRelayTrims.value[indexPath.row]
                shared.carInfo.trim = selectedItem
                let vc = ColorViewController(nibName: "ColorViewController", bundle: nil)
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
        
        viewModel.trimItems
            .drive(tableView.rx.items(cellIdentifier: "CustomTableViewCell", cellType: CustomTableViewCell.self)) { (row, element, cell) in
                if let name = element.name {
                    cell.configure(title: name)
                }
            }
            .disposed(by: disposeBag)
    }
}
