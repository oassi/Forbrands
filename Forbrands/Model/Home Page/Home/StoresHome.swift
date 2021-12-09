//
//  Stores.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct StoresHome: Codable {
    
    enum CodingKeys: String, CodingKey {
        case image
        case detail
        case name
        case id
    }
    
    var id: Int?
    var detail: String?
    var name: String?
    var image: String?
    
    
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.image) {                       
            image = String(value)                                                                                     
        }else if let value = try? container.decode(String.self, forKey:.image) {
            image = value                                                                                     
        }
        if let value = try? container.decode(Int.self, forKey:.detail) {                       
            detail = String(value)                                                                                     
        }else if let value = try? container.decode(String.self, forKey:.detail) {
            detail = value                                                                                     
        }
        if let value = try? container.decode(Int.self, forKey:.name) {                       
            name = String(value)                                                                                     
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value                                                                                     
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)                                                                                     
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value 
        }
    }
    
}
