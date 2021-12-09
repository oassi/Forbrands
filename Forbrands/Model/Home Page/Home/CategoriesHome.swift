//
//  Categories.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct CategoriesHome: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case logo
        case id
    }
    
    var name: String?
    var logo: String?
    var id: Int?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(Int.self, forKey:.logo) {
            logo = String(value)
        }else if let value = try? container.decode(String.self, forKey:.logo) {
            logo = value                                                                                     
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
    }
    
}
