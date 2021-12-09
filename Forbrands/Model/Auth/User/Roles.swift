//
//  Roles.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Roles: Codable {
    
    enum CodingKeys: String, CodingKey {
        case guardName = "guard_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id
      
        case pivot
        case name
        case status
    }
    
    var guardName: String?
    var createdAt: String?
    var id: Int?
    var updatedAt: String?
    var pivot: Pivot?
    var name: String?
    var status: Int?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.guardName) {
            guardName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.guardName) {
            guardName = value
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
        
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
      
        pivot = try container.decodeIfPresent(Pivot.self, forKey: .pivot)
        if let value = try? container.decode(Int.self, forKey:.name) {                       
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(String.self, forKey:.status) {
            status = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.status) {
            status = value
        }
    }
    
}
