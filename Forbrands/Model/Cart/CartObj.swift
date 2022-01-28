//
//  CartObj.swift
//  Forbrands
//
//  Created by Osama Abu Assi on 27/01/2022.
//

import Foundation

import Foundation

struct CartObj: Codable {
    
    enum CodingKeys: String, CodingKey {
        case count
        //case dataCart = "data"
     
    }
    var count: Int?
    //var dataCart: [Cart]?

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.count) {
            count = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.count) {
            count = value
        }
      //  dataCart = try container.decodeIfPresent([Cart].self, forKey: .dataCart)
       
    }
    
}
