//
//  Categories.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct CategoriesHome: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case logo
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
    }
    
    var name: String?
    var logo: String?
    var id: Int?
    var nameAr: String?
    var nameEn: String?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(Int.self, forKey:.logo) {
            logo = String(value)
        }else if let value = try? container.decode(String.self, forKey:.logo) {
            logo = value                                                                                     
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
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
    }
    
}
