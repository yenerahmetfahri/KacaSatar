//
//  ModelListViewModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation
import RxSwift
import RxCocoa

class ModelListViewModel: BaseViewModel {
    
    var itemsRelayStringList = BehaviorRelay<[String]>(value: [])
    
    var modelItems: Driver<[String]> {
        return itemsRelayStringList.asDriver()
    }
    
    func fetchModelsData() {
        isLoadingRelay.accept(true)
        VehicleAPI.getPublicApiVehicleModels { data, error in
            self.isLoadingRelay.accept(false)
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            self.itemsRelayStringList.accept(data.map { String($0) })
        }
    }
}
