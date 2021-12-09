//
//  FavoriteList.swift
//
//  Created by osamaaassi on 01/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct FavoriteList: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case productId = "product_id"
        case product
       
      
    }
    var id: Int?
    var userId: Int?
    var productId: Int?
    var product: Product?
   
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.userId) {
            userId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.userId) {
            userId = value
        }
        product = try container.decodeIfPresent(Product.self, forKey: .product)
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(String.self, forKey:.productId) {
            productId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.productId) {
            productId = value
        }
    }
    
}
