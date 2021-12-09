//
//  ProductsByStore.swift
//
//  Created by osamaaassi on 31/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ProductsByStore: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case details
        case images
        case oldPrice = "old_price"
        case price
        case subCategoryId = "sub_category_id"
        case storeId = "store_id"
        case favorite
        case status
        case sizes
        case categoryId = "category_id"
        case currencyId = "currency_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        
        
        
    }
    
    var id: Int?
    var name: String?
    var details: String?
    var images: [String]?
    var subCategoryId: String?
    var favorite: Bool?
    var storeId: Int?
    var oldPrice: Int?
    var categoryId: Int?
    var price: Int?
    var status: Int?
    var currencyId: Int?
    var sizes: String?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        images = try container.decodeIfPresent([String].self, forKey: .images)

        if let value = try? container.decode(Int.self, forKey:.subCategoryId) {
            subCategoryId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.subCategoryId) {
            subCategoryId = value
        }
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite)
        if let value = try? container.decode(String.self, forKey:.storeId) {
            storeId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.storeId) {
            storeId = value
        }
        if let value = try? container.decode(String.self, forKey:.oldPrice) {
            oldPrice = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.oldPrice) {
            oldPrice = value
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(String.self, forKey:.categoryId) {
            categoryId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.categoryId) {
            categoryId = value
        }
        if let value = try? container.decode(String.self, forKey:.price) {
            price = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.price) {
            price = value
        }
        if let value = try? container.decode(String.self, forKey:.status) {
            status = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(Int.self, forKey:.details) {
            details = String(value)
        }else if let value = try? container.decode(String.self, forKey:.details) {
            details = value
        }
        if let value = try? container.decode(String.self, forKey:.currencyId) {
            currencyId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.currencyId) {
            currencyId = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.sizes) {
            sizes = String(value)
        }else if let value = try? container.decode(String.self, forKey:.sizes) {
            sizes = value
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
        if let value = try? container.decode(Int.self, forKey:.deletedAt) {
            deletedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.deletedAt) {
            deletedAt = value
        }
    }
    
}
