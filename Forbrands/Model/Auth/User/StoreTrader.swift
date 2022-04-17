//
//  StoreTrader.swift
//
//  Created by osamaaassi on 29/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct StoreTrader: Codable {
    
    enum CodingKeys: String, CodingKey {
        case iban
        case name
        case image
        case updatedAt = "updated_at"
        case status
        case videoLink = "video_link"
        case payMethods = "pay_methods"
        case id
        case commercialRecord = "commercial_record"
        case createdAt = "created_at"
        case userId = "user_id"
        case detail
        case colors
        case maroofLink = "maroof_link"
        case storePolicy = "store_policy"
    }
    
    var id: Int?
    var userId: Int?
    var image: String?
    var name: String?
    var iban: String?
    var status: Int?
    var videoLink: String?
    var payMethods: String?
    
    var commercialRecord: String?
    var createdAt: String?
    
    var detail: String?
    var colors: String?
    var maroofLink: String?
    var updatedAt: String?
    var storePolicy : String?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? container.decode(Int.self, forKey:.storePolicy) {
            storePolicy = String(value)
        }else if let value = try? container.decode(String.self, forKey:.storePolicy) {
            storePolicy = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.iban) {
            iban = String(value)
        }else if let value = try? container.decode(String.self, forKey:.iban) {
            iban = value
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
        if let value = try? container.decode(Int.self, forKey:.videoLink) {
            videoLink = String(value)
        }else if let value = try? container.decode(String.self, forKey:.videoLink) {
            videoLink = value
        }
        if let value = try? container.decode(Int.self, forKey:.payMethods) {
            payMethods = String(value)
        }else if let value = try? container.decode(String.self, forKey:.payMethods) {
            payMethods = value
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(Int.self, forKey:.commercialRecord) {
            commercialRecord = String(value)
        }else if let value = try? container.decode(String.self, forKey:.commercialRecord) {
            commercialRecord = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(String.self, forKey:.userId) {
            userId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.userId) {
            userId = value
        }
        if let value = try? container.decode(Int.self, forKey:.detail) {
            detail = String(value)
        }else if let value = try? container.decode(String.self, forKey:.detail) {
            detail = value
        }
        if let value = try? container.decode(Int.self, forKey:.colors) {
            colors = String(value)
        }else if let value = try? container.decode(String.self, forKey:.colors) {
            colors = value
        }
        if let value = try? container.decode(Int.self, forKey:.maroofLink) {
            maroofLink = String(value)
        }else if let value = try? container.decode(String.self, forKey:.maroofLink) {
            maroofLink = value
        }
    }
    
}
