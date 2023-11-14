//
//  TrimsListViewModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation

class TrimsListViewModel: BaseViewModel {
    
    var trimsData = Trims()
    var bodyTypes = [Config]()
    var selectedBodyType: Config?
    var engineTypes = [Config]()
    var selectedEngineType: Config?
    var transmissionTypes = [Config]()
    var selectedTransmissionType: Config?
    
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
            
            self.trimsData = data
            completion(.success(data))
        }
    }
    
    func getBodyTypes() {
        let tempList = trimsData.filter {$0.bodyConfig != nil}.map { $0.bodyConfig!}
        
        bodyTypes = Array(Set(tempList))
    }
    
    func getEngineTypes(selectedBodyType: Config) {
        self.selectedBodyType = selectedBodyType
        let tempList = trimsData.filter { $0.bodyConfig == selectedBodyType && $0.engine != nil}.map { $0.engine!}
        
        engineTypes = Array(Set(tempList))
    }
    
    func getTransmissionTypes(selectedBodyType: Config,
                              selectedEngineType: Config) {
        self.selectedEngineType = selectedEngineType
        let tempList = trimsData.filter { $0.bodyConfig == selectedBodyType && $0.engine == selectedEngineType && $0.transmission != nil}.map { $0.transmission! }
        
        transmissionTypes = Array(Set(tempList))
    }
}

enum DataError: Error {
    case emptyData
}
