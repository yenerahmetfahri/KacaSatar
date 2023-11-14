//
// VehicleAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class VehicleAPI {
    
    open class func getPublicApiVehicleColors(completion: @escaping ((_ data: BasicFeatures?,_ error: Error?) -> Void)) {
        getPublicApiVehicleColorsWithRequestBuilder().execute { (response, error) -> Void in
            if error == nil {
                completion(response?.body, error)
            } else {
                completion(nil, error)
            }
        }
    }

    open class func getPublicApiVehicleColorsWithRequestBuilder() -> RequestBuilder<BasicFeatures> {
        let path = "/public/api/vehicles/colors"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<BasicFeatures>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    open class func getPublicApiVehicleMakesByModel(model: String, completion: @escaping ((_ data: BasicFeatures?,_ error: Error?) -> Void)) {
        getPublicApiVehicleMakesByModelWithRequestBuilder(model: model).execute { (response, error) -> Void in
            if error == nil {
                completion(response?.body, error)
            } else {
                completion(nil, error)
            }
        }
    }

    open class func getPublicApiVehicleMakesByModelWithRequestBuilder(model: String) -> RequestBuilder<BasicFeatures> {
        var path = "/public/api/vehicles/models/{model}/makes"
        let modelPreEscape = "\(model)"
        let modelPostEscape = modelPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{model}", with: modelPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<BasicFeatures>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    open class func getPublicApiVehicleModels(completion: @escaping ((_ data: [Int]?,_ error: Error?) -> Void)) {
        getPublicApiVehicleModelsWithRequestBuilder().execute { (response, error) -> Void in
            if error == nil {
                completion(response?.body, error)
            } else {
                completion(nil, error)
            }
        }
    }

    open class func getPublicApiVehicleModelsWithRequestBuilder() -> RequestBuilder<[Int]> {
        let path = "/public/api/vehicles/models"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<[Int]>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    open class func getPublicApiVehicleSeriesByModelAndMake(model: String, makeId: String, completion: @escaping ((_ data: BasicFeatures?,_ error: Error?) -> Void)) {
        getPublicApiVehicleSeriesByModelAndMakeWithRequestBuilder(model: model, makeId: makeId).execute { (response, error) -> Void in
            if error == nil {
                completion(response?.body, error)
            } else {
                completion(nil, error)
            }
        }
    }

    open class func getPublicApiVehicleSeriesByModelAndMakeWithRequestBuilder(model: String, makeId: String) -> RequestBuilder<BasicFeatures> {
        var path = "/public/api/vehicles/models/{model}/makes/{makeId}/series"
        let modelPreEscape = "\(model)"
        let modelPostEscape = modelPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{model}", with: modelPostEscape, options: .literal, range: nil)
        let makeIdPreEscape = "\(makeId)"
        let makeIdPostEscape = makeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{makeId}", with: makeIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<BasicFeatures>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    open class func getPublicApiVehicleTrimsByModelMakeAndSerie(model: String, makeId: String, serieId: String, completion: @escaping ((_ data: Trims?,_ error: Error?) -> Void)) {
        getPublicApiVehicleTrimsByModelMakeAndSerieWithRequestBuilder(model: model, makeId: makeId, serieId: serieId).execute { (response, error) -> Void in
            if error == nil {
                completion(response?.body, error)
            } else {
                completion(nil, error)
            }
        }
    }

    open class func getPublicApiVehicleTrimsByModelMakeAndSerieWithRequestBuilder(model: String, makeId: String, serieId: String) -> RequestBuilder<Trims> {
        var path = "/public/api/vehicles/models/{model}/makes/{makeId}/series/{serieId}/trims"
        let modelPreEscape = "\(model)"
        let modelPostEscape = modelPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{model}", with: modelPostEscape, options: .literal, range: nil)
        let makeIdPreEscape = "\(makeId)"
        let makeIdPostEscape = makeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{makeId}", with: makeIdPostEscape, options: .literal, range: nil)
        let serieIdPreEscape = "\(serieId)"
        let serieIdPostEscape = serieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{serieId}", with: serieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Trims>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}