//
//  ProductByID.swift
//  Forbrands
//
//  Created by osamaaassi on 09/09/2021.
//

import Foundation

struct ProductByID: Codable {
    
    enum CodingKeys: String, CodingKey {
        case user
        case roleName = "role_name"
        case product
    }
    
    var user: UserStruct?
    var roleName: String?
    var product: Product?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.roleName) {
            roleName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.roleName) {
            roleName = value
        }
        user = try container.decodeIfPresent(UserStruct.self, forKey: .user)
        product = try container.decodeIfPresent(Product.self, forKey: .product)
        
    }
    
}
