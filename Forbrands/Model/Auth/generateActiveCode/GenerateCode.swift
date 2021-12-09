//
//  GenerateCode.swift
//  Forbrands
//
//  Created by osamaaassi on 26/08/2021.
//

import Foundation


struct GenerateCode: Codable {
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case code
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case statusID = "status"
       
        
       
    }
    
    var userID: String?
    var code: Int?
    var updatedAt: String?
    var createdAt: String?
    var id: Int?
    var statusID: Int?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.userID) {
            userID = String(value)
        }else if let value = try? container.decode(String.self, forKey:.userID) {
            userID = value
        }
        
        if let value = try? container.decode(String.self, forKey:.code) {
            code = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.code) {
            code = value
        }

        if let value = try? container.decode(Int.self, forKey:.updatedAt) {
            updatedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.updatedAt) {
            updatedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(String.self, forKey:.statusID) {
            statusID = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.statusID) {
            statusID = value
        }
    }
    
}
