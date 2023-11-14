//
//  CustomPickerView.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 12.11.2023.
//

import Foundation
import UIKit

class CustomPickerView: UIPickerView {
    
    var doneButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Seç", style: .done, target: self, action: #selector(doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [spaceButton, doneButton]
        return toolbar
    }
    
    @objc private func doneButtonAction() {
        doneButtonTapped?()
    }
}
