//
//  Extension+UITextField.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import UIKit

extension UITextField {
    func formatCurrency() {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc private func editingChanged() {
        guard let text = text, text.count <= 10 else { return }
        
        let cleanText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.numberStyle = .decimal
        if !cleanText.isEmpty, let cleanDouble = Double(cleanText) {
            if let formattedNumber = formatter.string(from: NSNumber(value: cleanDouble)) {
                self.text = formattedNumber
            }
        }
    }
    
    func setMaxLength(_ maxLength: Int) {
        addTarget(self, action: #selector(limitLength), for: .editingChanged)
        maxLengthAssociation = maxLength
    }
    
    private var maxLengthAssociation: Int? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.maxLength) as? Int
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.maxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @objc private func limitLength() {
        guard let maxLength = maxLengthAssociation, let text = text else { return }
        let truncatedText = String(text.prefix(maxLength))
        if text != truncatedText {
            self.text = truncatedText
        }
    }
    
    private struct AssociatedKeys {
        static var maxLength = "maxLength"
    }
}
