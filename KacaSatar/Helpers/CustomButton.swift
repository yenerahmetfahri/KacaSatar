//
//  CustomButton.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(red: 255/255, green: 61/255, blue: 85/255, alpha: 1.0)
        layer.cornerRadius = 10.0
    }
}
