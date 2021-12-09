//
//  Reviews.swift
//
//  Created by osamaaassi on 17/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Reviews: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case rating
        case comment
        case userName = "user_name"
        case createdAt = "created_at"
        case orderId = "order_id"
        case date
        case userImage = "user_image"
    }
    
    var rating: String?
    var userName: String?
    var comment: String?
    var orderId: Int?
    var id: Int?
    var date: String?
    var createdAt: String?
    var userImage: String?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.rating) {
            rating = String(value)
        }else if let value = try? container.decode(String.self, forKey:.rating) {
            rating = value
        }
        if let value = try? container.decode(Int.self, forKey:.userName) {
            userName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.userName) {
            userName = value
        }
        if let value = try? container.decode(Int.self, forKey:.comment) {
            comment = String(value)
        }else if let value = try? container.decode(String.self, forKey:.comment) {
            comment = value
        }
        if let value = try? container.decode(String.self, forKey:.orderId) {
            orderId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.orderId) {
            orderId = value
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(Int.self, forKey:.date) {
            date = String(value)
        }else if let value = try? container.decode(String.self, forKey:.date) {
            date = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.userImage) {
            userImage = String(value)
        }else if let value = try? container.decode(String.self, forKey:.userImage) {
            userImage = value                                                                                     
        }
    }
    
}
