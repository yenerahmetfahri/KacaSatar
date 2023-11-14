//
//  BasicFeatures.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 10.11.2023.
//

import Foundation

public typealias BasicFeatures = [BasicFeature]

public struct BasicFeature: Codable {
    let id: Int?
    let name: String?
    let code: String?
}
