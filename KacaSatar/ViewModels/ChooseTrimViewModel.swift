//
//  ChooseTrimViewModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 12.11.2023.
//

import Foundation
import RxSwift
import RxCocoa

class ChooseTrimViewModel: BaseViewModel {
    
    var trimsData = Trims()
    
    var itemsRelayTrims = BehaviorRelay<Trims>(value: [])
    
    var trimItems: Driver<Trims> {
        return itemsRelayTrims.asDriver()
    }
    
    func fetchTrimsData(model: String, makeId: String, serieId: String, completion: @escaping (Result<Trims, Error>) -> Void) {
        isLoadingRelay.accept(true)
        VehicleAPI.getPublicApiVehicleTrimsByModelMakeAndSerie(model: model, makeId: makeId, serieId: serieId) { data, error in
            self.isLoadingRelay.accept(false)
            if let error = error {
                print(error)
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(DataError.emptyData))
                return
            }
            
            let carInfo = DataManager.shared.carInfo
            if let body = carInfo.bodyConfig, let engine = carInfo.engine, let transmission = carInfo.transmission {
                self.trimsData = data.filter { $0.bodyConfig == body && $0.engine == engine && $0.transmission == transmission }
                self.itemsRelayTrims.accept(self.trimsData)
                completion(.success(data))
            } else {
                completion(.failure(DataError.emptyData))
            }
        }
    }
    
}
