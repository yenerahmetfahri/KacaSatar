//
//  ViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 10.11.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
        self.view.addSubview(logoImageView)
        logoImageView.frame = CGRect(x: view.frame.width, y: (view.frame.height - 170) / 2, width: 170, height: 170)
        logoImageView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 1.0) {
            self.logoImageView.frame = CGRect(x: (self.view.frame.width - 170) / 2, y: (self.view.frame.height - 170) / 2, width: 170, height: 170)
        }
    }
    
    
    @IBAction func startButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
            self.logoImageView.frame.origin.x -= 300
        } completion: { _ in
            let vc = FeatureListViewController(nibName: "FeatureListViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController {
    private func setupView() {
        startButton.layer.cornerRadius = 10.0
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 3.0
        logoImageView.layer.masksToBounds = true
    }
}
