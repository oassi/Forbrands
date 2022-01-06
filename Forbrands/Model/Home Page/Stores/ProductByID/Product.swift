//
//  Product.swift
//
//  Created by osamaaassi on 09/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Product: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case detailsEn = "details_en"
        case detailsAr = "details_ar"
        case sizes
        case images
        case price
        case oldPrice = "old_price"
        case currencyId = "currency_id"
        case categoryId = "category_id"
        case subCategoryId = "sub_category_id"
        case storeId = "store_id"
        case currency
        case category
        case status
        case store
        case favorite
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case deletedAt = "deleted_at"
        case reviewsAverage = "reviews_average"
        case reviewsCount = "reviews_count"
        case reviews
        case amount
        case returnProduct = "returnproduct"
        
        
        
        
    }
    var id: Int?
    var nameAr: String?
    var nameEn: String?
    var detailsAr: String?
    var detailsEn: String?
    var sizes: [String]?
    var images: [String]?
    var price: String?
    var currencyId: String?
    var categoryId: String?
    var storeId: String?
    var createdAt: String?
    var deletedAt: String?
    var oldPrice: String?
    var currency: String?
    var category: String?
    var store: String?
    var status: String?
    var updatedAt: String?
    var subCategoryId: String?
    var favorite: Bool?
    var reviewsAverage: Int?
    var reviewsCount: Int?
    var reviews: Int?
    var amount: Int?
    var returnProduct: String?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(String.self, forKey:.amount) {
            amount = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.amount) {
            amount = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.store) {
            store = String(value)
        }else if let value = try? container.decode(String.self, forKey:.store) {
            store = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.category) {
            category = String(value)
        }else if let value = try? container.decode(String.self, forKey:.category) {
            category = value
        }
        if let value = try? container.decode(Int.self, forKey:.currency) {
            currency = String(value)
        }else if let value = try? container.decode(String.self, forKey:.currency) {
            currency = value
        }
        if let value = try? container.decode(Int.self, forKey:.currencyId) {
            currencyId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.currencyId) {
            currencyId = value
        }
        if let value = try? container.decode(Int.self, forKey:.subCategoryId) {
            subCategoryId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.subCategoryId) {
            subCategoryId = value
        }
        if let value = try? container.decode(Int.self, forKey:.price) {
            price = String(value)
        }else if let value = try? container.decode(String.self, forKey:.price) {
            price = value
        }
        if let value = try? container.decode(Int.self, forKey:.nameEn) {
            nameEn = String(value)
        }else if let value = try? container.decode(String.self, forKey:.nameEn) {
            nameEn = value
        }
        if let value = try? container.decode(Int.self, forKey:.oldPrice) {
            oldPrice = String(value)
        }else if let value = try? container.decode(String.self, forKey:.oldPrice) {
            oldPrice = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.deletedAt) {
            deletedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.deletedAt) {
            deletedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.storeId) {
            storeId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.storeId) {
            storeId = value
        }
        if let value = try? container.decode(Int.self, forKey:.detailsEn) {
            detailsEn = String(value)
        }else if let value = try? container.decode(String.self, forKey:.detailsEn) {
            detailsEn = value
        }
        if let value = try? container.decode(Int.self, forKey:.detailsAr) {
            detailsAr = String(value)
        }else if let value = try? container.decode(String.self, forKey:.detailsAr) {
            detailsAr = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.status) {
            status = String(value)
        }else if let value = try? container.decode(String.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(Int.self, forKey:.nameAr) {
            nameAr = String(value)
        }else if let value = try? container.decode(String.self, forKey:.nameAr) {
            nameAr = value
        }
        if let value = try? container.decode(Int.self, forKey:.updatedAt) {
            updatedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.updatedAt) {
            updatedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.categoryId) {
            categoryId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.categoryId) {
            categoryId = value
        }
        if let value = try? container.decode(String.self, forKey:.reviewsAverage) {
            reviewsAverage = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.reviewsAverage) {
            reviewsAverage = value
        }
        if let value = try? container.decode(String.self, forKey:.reviewsCount) {
            reviewsCount = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.reviewsCount) {
            reviewsCount = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.returnProduct) {
            returnProduct = String(value)
        }else if let value = try? container.decode(String.self, forKey:.returnProduct) {
            returnProduct = value
        }
        
        
        sizes = try container.decodeIfPresent([String].self, forKey: .sizes)
        images = try container.decodeIfPresent([String].self, forKey: .images)
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite)
        
    }
    
}
