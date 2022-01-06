//
//  Favorite.swift
//
//  Created by osamaaassi on 12/12/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Favorite: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case productId = "product_id"
        case createdAt = "created_at"
        case userId = "user_id"
      
        
    }
    
    var id: Int?
    var updatedAt: String?
    var productId: String?
    var createdAt: String?
    var userId: Int?
    
  
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(Int.self, forKey:.updatedAt) {
            updatedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.updatedAt) {
            updatedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.productId) {
            productId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.productId) {
            productId = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(String.self, forKey:.userId) {
            userId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.userId) {
            userId = value
        }
        
       
    }
    
}
