//
//  User.swift
//
//  Created by osamaaassi on 22/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct UserStruct: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case email
        case status
        case phone
        case phoneVerifiedAt = "phone_verified_at"
        case image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case deletedAt = "deleted_at"
        case idHash = "id_hash"
        case emailVerifiedAt = "email_verified_at"
        case roles
    }
    
    var emailVerifiedAt: String?
    var phoneVerifiedAt: String?
    var updatedAt: String?
    var status: Int?
    var deletedAt: String?
    var id: Int?
    var username: String?
    var email: String?
    var createdAt: String?
    var phone: String?
    var idHash: Int?
    var name: String?
    var image: String?
    var roles: [Roles]?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        roles = try container.decodeIfPresent([Roles].self, forKey: .roles)
        
        if let value = try? container.decode(Int.self, forKey:.emailVerifiedAt) {
            emailVerifiedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.emailVerifiedAt) {
            emailVerifiedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.phoneVerifiedAt) {
            phoneVerifiedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.phoneVerifiedAt) {
            phoneVerifiedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.updatedAt) {
            updatedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.updatedAt) {
            updatedAt = value
        }
        if let value = try? container.decode(String.self, forKey:.status) {
            status = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(Int.self, forKey:.deletedAt) {
            deletedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.deletedAt) {
            deletedAt = value
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(Int.self, forKey:.username) {
            username = String(value)
        }else if let value = try? container.decode(String.self, forKey:.username) {
            username = value
        }
        if let value = try? container.decode(Int.self, forKey:.email) {
            email = String(value)
        }else if let value = try? container.decode(String.self, forKey:.email) {
            email = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.phone) {
            phone = String(value)
        }else if let value = try? container.decode(String.self, forKey:.phone) {
            phone = value
        }
        if let value = try? container.decode(String.self, forKey:.idHash) {
            idHash = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.idHash) {
            idHash = value
        }
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(Int.self, forKey:.image) {
            image = String(value)
        }else if let value = try? container.decode(String.self, forKey:.image) {
            image = value
        }
    }
    
}
