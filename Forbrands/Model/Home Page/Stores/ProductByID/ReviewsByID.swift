//
//  ReviewsByID.swift
//
//  Created by osamaaassi on 17/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ReviewsByID: Codable {
    
    enum CodingKeys: String, CodingKey {
        case reviews
        case reviewsAverage = "reviews_average"
        case reviewsCount = "reviews_count"
    }
    
    var reviews: [Reviews]?
    var reviewsAverage: String?
    var reviewsCount: Int?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reviews = try container.decodeIfPresent([Reviews].self, forKey: .reviews)
       
        if let value = try? container.decode(Int.self, forKey:.reviewsAverage) {
            reviewsAverage = String(value)
        } else if let value = try? container.decode(String.self, forKey:.reviewsAverage) {
            reviewsAverage = value
        }
        
        if let value = try? container.decode(String.self, forKey:.reviewsCount) {
            reviewsCount = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.reviewsCount) {
            reviewsCount = value
        }
    }
    
}
