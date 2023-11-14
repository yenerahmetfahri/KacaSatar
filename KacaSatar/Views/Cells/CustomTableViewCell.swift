//
//  CustomTableViewCell.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: ShadowView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(title: String) {
        cellLabel.text = title
    }
    
    private func setupView() {
        cellView.layer.cornerRadius = 5.0
        cellView.layer.shadowRadius = 5.0
        cellView.layer.shadowColor = UIColor.gray.cgColor
    }
    
}
