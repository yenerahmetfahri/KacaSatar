//
//  PriceResult.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation

public struct PriceResult: Codable {
    let id: Int?
    let price: Int?
    let code: String?
    let transmission: Config?
    let engine: Config?
    let randomID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case price
        case code
        case transmission
        case engine
        case randomID = "random_id"
    }
}
