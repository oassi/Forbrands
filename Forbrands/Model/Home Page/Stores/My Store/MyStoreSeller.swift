//
//  MyStoreSeller.swift
//  Forbrands
//
//  Created by osamaaassi on 07/09/2021.
//

import Foundation

struct MyStoreSeller: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case image
        case categories
        
    }
    
    var image: String?
    var categories: [CategoriesHome]?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categories = try container.decodeIfPresent([CategoriesHome].self, forKey: .categories)
        
        if let value = try? container.decode(Int.self, forKey:.image) {
            image = String(value)
        }else if let value = try? container.decode(String.self, forKey:.image) {
            image = value
        }
    }
    
}
