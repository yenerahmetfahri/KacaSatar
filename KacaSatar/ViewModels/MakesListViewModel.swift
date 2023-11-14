//
//  MakesListViewModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation
import RxSwift
import RxCocoa

class MakesListViewModel: BaseViewModel {
    
    var itemsRelayBasicFeature = BehaviorRelay<BasicFeatures>(value: [])
    
    var basicFeatureItems: Driver<BasicFeatures> {
        return itemsRelayBasicFeature.asDriver()
    }
    
    func fetchMakesData(model: String) {
        isLoadingRelay.accept(true)
        VehicleAPI.getPublicApiVehicleMakesByModel(model: model, completion: { data, error in
            self.isLoadingRelay.accept(false)
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            self.itemsRelayBasicFeature.accept(data)
        })
    }

    func fetchSeriesData(model: String, makeId: String) {
        isLoadingRelay.accept(true)
        VehicleAPI.getPublicApiVehicleSeriesByModelAndMake(model: model, makeId: makeId) { data, error in
            self.isLoadingRelay.accept(false)
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                return
            }
            
            self.itemsRelayBasicFeature.accept(data)
        }
    }
}
