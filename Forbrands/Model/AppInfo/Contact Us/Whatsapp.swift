//
//  Whatsapp.swift
//
//  Created by osamaaassi on 07/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Whatsapp: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case valueLink = "value"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
        
    }
    
    var id: Int?
    var name: String?
    var valueLink: String?
    var createdAt: String?
    var updatedAt: String?
    
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.valueLink) {
            valueLink = String(value)
        }else if let value = try? container.decode(String.self, forKey:.valueLink) {
            valueLink = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.updatedAt) {
            updatedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.updatedAt) {
            updatedAt = value
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
