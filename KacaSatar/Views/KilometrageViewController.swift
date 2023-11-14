//
//  KilometrageViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import UIKit
import SwiftUI

class KilometrageViewController: BaseViewController {

    @IBOutlet weak var kilometrageTextField: UITextField!
    @IBOutlet weak var continueButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Kilometre"
        setupView()

    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        
        let kilometrage = kilometrageTextField.text?.removeDots()
        
        if kilometrage != "", Int(kilometrage ?? "0") ?? 0 > 0 {
            shared.carInfo.kilometerage = kilometrage
            let swiftUIHostingController = UIHostingController(rootView: ShowPriceViewController(viewModel: ResultListViewModel()))
            
            navigationItem.title = "Teklifimiz"
            let navigationController = UINavigationController(rootViewController: swiftUIHostingController)
            addChild(navigationController)
            view.addSubview(navigationController.view)
            navigationController.didMove(toParent: self)
        } else {
            showAlert(title: "Uyarı!", message: "Lütfen kilometre bilgisi alanını boş bırakmayınız ve 0'dan büyük bir değer giriniz.")
        }
    }
}

//MARK: - Auxilary Methods
extension KilometrageViewController {
    private func setupView() {
        kilometrageTextField.formatCurrency()
        kilometrageTextField.setMaxLength(10)
    }
}
