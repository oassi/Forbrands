//
//  ProductAndReviews.swift
//
//  Created by osamaaassi on 17/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ProductAndReviews: Codable {
    
    enum CodingKeys: String, CodingKey {
        case storeName = "store_name"
        case reviewsCount = "reviews_count"
        case price
        case id
        case reviews
        case detailsAr = "details_ar"
        case storeId = "store_id"
        case images
        case categoryId = "category_id"
        case status
        case oldPrice = "old_price"
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case reviewsAverage = "reviews_average"
        case sizes
        case detailsEn = "details_en"
        case currencyId = "currency_id"
        case favorite
    }
    
    var storeName: String?
    var reviewsCount: Int?
    var price: String?
    var id: Int?
    var reviews: [Reviews]?
    var detailsAr: String?
    var storeId: Int?
    var images: [String]?
    var categoryId: Int?
    var status: Int?
    var oldPrice: String?
    var nameEn: String?
    var nameAr: String?
    var reviewsAverage: String?
    var sizes: [String]?
    var detailsEn: String?
    var currencyId: Int?
    var favorite: Bool?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.storeName) {
            storeName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.storeName) {
            storeName = value
        }
        if let value = try? container.decode(String.self, forKey:.reviewsCount) {
            reviewsCount = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.reviewsCount) {
            reviewsCount = value
        }
        if let value = try? container.decode(Int.self, forKey:.price) {
            price = String(value)
        }else if let value = try? container.decode(String.self, forKey:.price) {
            price = value
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        reviews = try container.decodeIfPresent([Reviews].self, forKey: .reviews)
        if let value = try? container.decode(Int.self, forKey:.detailsAr) {
            detailsAr = String(value)
        }else if let value = try? container.decode(String.self, forKey:.detailsAr) {
            detailsAr = value
        }
        if let value = try? container.decode(String.self, forKey:.storeId) {
            storeId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.storeId) {
            storeId = value
        }
       
        if let value = try? container.decode(String.self, forKey:.categoryId) {
            categoryId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.categoryId) {
            categoryId = value
        }
        if let value = try? container.decode(String.self, forKey:.status) {
            status = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(Int.self, forKey:.oldPrice) {
            oldPrice = String(value)
        }else if let value = try? container.decode(String.self, forKey:.oldPrice) {
            oldPrice = value
        }
        if let value = try? container.decode(Int.self, forKey:.nameEn) {
            nameEn = String(value)
        }else if let value = try? container.decode(String.self, forKey:.nameEn) {
            nameEn = value
        }
        if let value = try? container.decode(Int.self, forKey:.nameAr) {
            nameAr = String(value)
        }else if let value = try? container.decode(String.self, forKey:.nameAr) {
            nameAr = value
        }
        if let value = try? container.decode(Int.self, forKey:.reviewsAverage) {
            reviewsAverage = String(value)
        }else if let value = try? container.decode(String.self, forKey:.reviewsAverage) {
            reviewsAverage = value
        }
        if let value = try? container.decode(Int.self, forKey:.detailsEn) {
            detailsEn = String(value)
        }else if let value = try? container.decode(String.self, forKey:.detailsEn) {
            detailsEn = value
        }
        if let value = try? container.decode(String.self, forKey:.currencyId) {
            currencyId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.currencyId) {
            currencyId = value
        }
        images = try container.decodeIfPresent([String].self, forKey: .images)
        sizes = try container.decodeIfPresent([String].self, forKey: .sizes)
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite)
    }
    
}
