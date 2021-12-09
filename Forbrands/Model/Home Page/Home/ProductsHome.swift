//
//  Products.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ProductsHome: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case currency
        case category
        case storeId = "store_id"
        case currencyId = "currency_id"
        
        case categoryId = "category_id"
        case price
        case id
        case images
        case store
        case details
    }
    
    var name: String?
    var currency: String?
    var storeId: Int?
    var currencyId: Int?
    var category: String?
    var categoryId: Int?
    var price: Int?
    var id: Int?
    var images: String?
    var store: String?
    var details: String?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(Int.self, forKey:.currency) {
            currency = String(value)
        }else if let value = try? container.decode(String.self, forKey:.currency) {
            currency = value
        }
        if let value = try? container.decode(String.self, forKey:.storeId) {
            storeId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.storeId) {
            storeId = value
        }
        if let value = try? container.decode(String.self, forKey:.currencyId) {
            currencyId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.currencyId) {
            currencyId = value
        }
        if let value = try? container.decode(Int.self, forKey:.category) {
            category = String(value)
        }else if let value = try? container.decode(String.self, forKey:.category) {
            category = value
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
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(Int.self, forKey:.images) {
            images = String(value)
        }else if let value = try? container.decode(String.self, forKey:.images) {
            images = value
        }
        if let value = try? container.decode(Int.self, forKey:.store) {
            store = String(value)
        }else if let value = try? container.decode(String.self, forKey:.store) {
            store = value
        }
        if let value = try? container.decode(Int.self, forKey:.details) {
            details = String(value)
        }else if let value = try? container.decode(String.self, forKey:.details) {
            details = value
        }
    }
    
}
