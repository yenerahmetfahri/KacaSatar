//
//  ResultListViewModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation

class ResultListViewModel: ObservableObject {
    
    @Published var result: PriceResult?
    
    let carInfo = DataManager.shared.carInfo
    
    func fetchData(completion: @escaping (Result<PriceResult, Error>) -> Void) {
        if let trimId = carInfo.trim?.id , let model = carInfo.model, let kilometrage = carInfo.kilometerage, let color = carInfo.color?.id {
            PricingAPI.postPublicApiPricingGerenate(body: ApiPricingsBody(trimId: String(trimId), model: model, kilometerage: kilometrage, colorId: String(color), expertise: "true")) { data, error in
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(DataError.emptyData))
                    return
                }
                self.result = data
                completion(.success(data))
            }
        }
    }
}
