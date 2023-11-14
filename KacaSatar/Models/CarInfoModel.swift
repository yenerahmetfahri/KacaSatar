//
//  CarInfoModel.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 11.11.2023.
//

import Foundation

struct CarInfoModel {
    var trim: Trim?
    var makes: BasicFeature?
    var model: String?
    var kilometerage: String?
    var color: BasicFeature?
    var series: BasicFeature?
    var bodyConfig: Config?
    var engine: Config?
    var transmission: Config?
    
    var makeAndModel: String {
        var text = ""
        if let makeName = makes?.name, makeName != "" {
            text += makeName + " "
        }
        if let trimName = trim?.name, trimName != "" {
            text += trimName
        }
        return text
    }
}
