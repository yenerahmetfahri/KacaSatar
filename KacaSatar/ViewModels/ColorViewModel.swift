//
//  ColorViewModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import Foundation
import RxSwift
import RxCocoa

class ColorViewModel: BaseViewModel {
    
    var itemsRelayColor = BehaviorRelay<BasicFeatures>(value: [])
    
    var colorItems: Driver<BasicFeatures> {
        return itemsRelayColor.asDriver()
    }
    
    func fetchColorData() {
        isLoadingRelay.accept(true)
        VehicleAPI.getPublicApiVehicleColors { data, error in
            self.isLoadingRelay.accept(false)
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            self.itemsRelayColor.accept(data)
        }
    }
}
