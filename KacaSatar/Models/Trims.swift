//
//  Trims.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation

public typealias Trims = [Trim]

public struct Trim: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let displacement: String?
    let bodyConfig: Config?
    let transmission: Config?
    let engine: Config?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case displacement
        case bodyConfig = "body_config"
        case transmission
        case engine
    }
}
