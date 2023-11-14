//
//  TrimsListViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import UIKit
import RxSwift
import RxCocoa

class TrimsListViewController: BaseViewController {
    
    @IBOutlet weak var bodyTypeTextField: UITextField!
    @IBOutlet weak var engineTypeTextField: UITextField!
    @IBOutlet weak var transmissionTypeTextField: UITextField!
    
    private let bodyPickerView = CustomPickerView()
    private let enginePickerView = CustomPickerView()
    private let transmissionPickerView = CustomPickerView()
    
    var viewModel = TrimsListViewModel()
    
    var selectedBody: Config?
    var selectedEngine: Config?
    var selectedTransmission: Config?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Özellikler"
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let model = shared.carInfo.model, let makes = shared.carInfo.makes?.id, let series = shared.carInfo.series?.id {
            viewModel.fetchTrimsData(model: model, makeId: String(makes), serieId: String(series)) { result in
                switch result {
                case .success(_):
                    self.viewModel.getBodyTypes()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: - Action Methods
extension TrimsListViewController {
    @IBAction func continueButtonAction(_ sender: Any) {
        if let body = selectedBody, let engine = selectedEngine, let transmission = selectedTransmission {
            shared.carInfo.bodyConfig = body
            shared.carInfo.engine = engine
            shared.carInfo.transmission = transmission
            let vc = ChooseTrimViewController(nibName: "ChooseTrimViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            showAlert(title: "Uyarı!", message: "Lütfen tüm alanları seçiniz.")
        }
    }
}

//MARK: - Auxilary Methods
extension TrimsListViewController {
    
    private func setupView() {
        bodyTypeTextField.inputView = bodyPickerView
        engineTypeTextField.inputView = enginePickerView
        transmissionTypeTextField.inputView = transmissionPickerView
        
        bodyPickerView.delegate = self
        bodyPickerView.dataSource = self
        enginePickerView.delegate = self
        enginePickerView.dataSource = self
        transmissionPickerView.delegate = self
        transmissionPickerView.dataSource = self
        
        bodyTypeTextField.delegate = self
        engineTypeTextField.delegate = self
        transmissionTypeTextField.delegate = self
        
        bodyTypeTextField.inputAccessoryView = bodyPickerView.createToolbar()
        engineTypeTextField.inputAccessoryView = enginePickerView.createToolbar()
        transmissionTypeTextField.inputAccessoryView = transmissionPickerView.createToolbar()
        
        engineTypeTextField.isUserInteractionEnabled = false
        transmissionTypeTextField.isUserInteractionEnabled = false
        
        bodyPickerView.doneButtonTapped = { [weak self] in
            self?.cleanTextField(selectedPickerId: 0)
            self?.bodyTypeTextField.resignFirstResponder()
        }
        
        enginePickerView.doneButtonTapped = { [weak self] in
            self?.cleanTextField(selectedPickerId: 1)
            self?.engineTypeTextField.resignFirstResponder()
        }
        
        transmissionPickerView.doneButtonTapped = { [weak self] in
            self?.cleanTextField(selectedPickerId: 2)
            self?.transmissionTypeTextField.resignFirstResponder()
        }
    }
    
    private func cleanTextField(selectedPickerId: Int) {
        switch selectedPickerId {
        case 0:
            selectedEngine = nil
            selectedTransmission = nil
            
            engineTypeTextField.text = ""
            transmissionTypeTextField.text = ""
            
            engineTypeTextField.isUserInteractionEnabled = true
            transmissionTypeTextField.isUserInteractionEnabled = false
            
            bodyTypeTextField.text = selectedBody?.name ?? viewModel.bodyTypes.first?.name
            if selectedBody == nil {
                selectedBody = viewModel.bodyTypes.first
            }
            viewModel.selectedBodyType = selectedBody
            viewModel.getEngineTypes(selectedBodyType: (selectedBody)!)
            
        case 1:
            selectedTransmission = nil
            
            transmissionTypeTextField.text = ""
            
            transmissionTypeTextField.isUserInteractionEnabled = true
            
            engineTypeTextField.text = selectedEngine?.name ?? viewModel.engineTypes.first?.name
            if selectedEngine == nil {
                selectedEngine = viewModel.engineTypes.first
            }
            viewModel.selectedBodyType = selectedBody
            viewModel.getTransmissionTypes(selectedBodyType: (viewModel.selectedBodyType)!, selectedEngineType: (selectedEngine)!)
            
        case 2:
            transmissionTypeTextField.text = selectedTransmission?.name ?? viewModel.transmissionTypes.first?.name
            if selectedTransmission == nil {
                selectedTransmission = viewModel.transmissionTypes.first
            }
            viewModel.selectedTransmissionType = selectedTransmission
        default:
            break
        }
    }
}

//MARK: - Pickerview Delegate Methods
extension TrimsListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case bodyPickerView:
            return viewModel.bodyTypes.count
        case enginePickerView:
            return viewModel.engineTypes.count
        case transmissionPickerView:
            return viewModel.transmissionTypes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case bodyPickerView:
            return viewModel.bodyTypes[row].name
        case enginePickerView:
            return viewModel.engineTypes[row].name
        case transmissionPickerView:
            return viewModel.transmissionTypes[row].name
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case bodyPickerView:
            selectedBody = viewModel.bodyTypes[row]
        case enginePickerView:
            selectedEngine = viewModel.engineTypes[row]
        case transmissionPickerView:
            selectedTransmission = viewModel.transmissionTypes[row]
        default:
            return
        }
    }
}

//MARK: - Textfield Delegate Methods
extension TrimsListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case bodyTypeTextField:
            bodyPickerView.reloadAllComponents()
        case engineTypeTextField:
            enginePickerView.reloadAllComponents()
        case transmissionTypeTextField:
            transmissionPickerView.reloadAllComponents()
        default:
            break
        }
    }
}
