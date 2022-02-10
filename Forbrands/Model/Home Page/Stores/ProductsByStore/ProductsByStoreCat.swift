//
//  ProductsByStoreCat.swift
//  Forbrands
//
//  Created by osamaaassi on 08/09/2021.
//

import Foundation
struct ProductsByStoreCat: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameAr   = "name_ar"
        case nameEn   = "name_en"
        case detailsAr = "details_ar"
        case detailsEn = "details_en"
        case sizes
        case images
        case oldPrice = "old_price"
        case price
        case currencyId = "currency_id"
        case categoryId = "category_id"
        case subCategoryId = "sub_category_id"
        case storeId = "store_id"
        case status
        case returnProduct = "returnproduct"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case favorite
        case deletedAt = "deleted_at"
        
        
        
       
        
       
        
        
        
    }
    
    var id: Int?
    var nameAr: String?
    var nameEn: String?
    var detailsAr: String?
    var detailsEn: String?
    var details: String?
    var images: String?
    var subCategoryId: String?
    var favorite: Bool?
    var storeId: Int?
    var oldPrice: Int?
    var categoryId: Int?
    var price: Int?
    var status: Int?
    var currencyId: Int?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    var returnProduct:String?
    var sizes: [String]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sizes = try container.decodeIfPresent([String].self, forKey: .sizes)
        
        if let value = try? container.decode(Int.self, forKey:.images) {
            images = String(value)
        }else if let value = try? container.decode(String.self, forKey:.images) {
            images = value
        }
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
        if let value = try? container.decode(Int.self, forKey:.nameAr) {
            nameAr = String(value)
        }else if let value = try? container.decode(String.self, forKey:.nameAr) {
            nameAr = value
        }
        if let value = try? container.decode(Int.self, forKey:.nameEn) {
            nameEn = String(value)
        }else if let value = try? container.decode(String.self, forKey:.nameEn) {
            nameEn = value
        }
        if let value = try? container.decode(Int.self, forKey:.detailsAr) {
            detailsAr = String(value)
        }else if let value = try? container.decode(String.self, forKey:.detailsAr) {
            detailsAr = value
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
        if let value = try? container.decode(Int.self, forKey:.returnProduct) {
            returnProduct = String(value)
        }else if let value = try? container.decode(String.self, forKey:.returnProduct) {
            returnProduct = value
        }
    }
    
}
