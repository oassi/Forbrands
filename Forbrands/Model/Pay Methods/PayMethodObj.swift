//
//  PayMethodObj.swift
//  Forbrands
//
//  Created by osamaaassi on 30/09/2021.
//

import Foundation


struct PayMethodObj: Codable {
    
    enum CodingKeys: String, CodingKey {

        case payMethods = "pay_methods"
    }

    var payMethods: [PayMethods]?
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        payMethods = try container.decodeIfPresent([PayMethods].self, forKey: .payMethods)


        
    }
    
}
