//
//  Point.swift
//  Forbrands
//
//  Created by osamaaassi on 16/12/2021.
//

import Foundation

struct Point: Codable {
    
    enum CodingKeys: String, CodingKey {
        case money
        case point
     
    }
    var money: Int?
    var point: Int?

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.money) {
            money = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.money) {
            money = value
        }
        if let value = try? container.decode(String.self, forKey:.point) {
            point = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.point) {
            point = value
        }
       
    }
    
}
