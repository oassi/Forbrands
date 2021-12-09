//
//  StatesList.swift
//  Forbrands
//
//  Created by osamaaassi on 29/08/2021.
//

import Foundation

struct StatesList: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case countryId = "country_id"
        case name
       
    }
    var id: Int?
    var name: String?
    var countryId: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(String.self, forKey:.countryId) {
            countryId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.countryId) {
            countryId = value
        }
      
        
    }
    
}

