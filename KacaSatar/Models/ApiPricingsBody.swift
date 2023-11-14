//
//  BasicFeatures.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 10.11.2023.
//

import Foundation

public struct ApiPricingsBody: Codable {

    public var trimId: String
    public var model: String
    public var kilometerage: String
    public var colorId: String
    public var expertise: String

    public init(trimId: String, model: String, kilometerage: String, colorId: String, expertise: String) {
        self.trimId = trimId
        self.model = model
        self.kilometerage = kilometerage
        self.colorId = colorId
        self.expertise = expertise
    }

    public enum CodingKeys: String, CodingKey { 
        case trimId = "trim_id"
        case model
        case kilometerage
        case colorId = "color_id"
        case expertise
    }
}
