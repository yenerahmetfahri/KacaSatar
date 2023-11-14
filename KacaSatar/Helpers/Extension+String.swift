//
//  Extension+String.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import Foundation

extension String {
    
    func removeDots() -> String {
        return replacingOccurrences(of: ".", with: "")
    }
    
    func formatAsNumber() -> String {
        if let number = Double(self) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.locale = Locale(identifier: "tr_TR")
            return numberFormatter.string(from: NSNumber(value: number)) ?? ""
        } else {
            return self
        }
    }
}
