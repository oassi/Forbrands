//
//  PayMethod.swift
//  Forbrands
//
//  Created by osamaaassi on 29/09/2021.
//

import Foundation
struct PayMethod: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        
        
    }
    
    var id: Int?
    var nameAr: String?
    var nameEn: String?
    var status: Int?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
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
