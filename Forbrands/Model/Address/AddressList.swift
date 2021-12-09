//
//  Data.swift
//
//  Created by osamaaassi on 29/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct AddressList: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case fullName = "full_name"
        case phone
        case phoneEx = "phone_ex"
        case street
        case stateId = "state_id"
        case cityId = "city_id"
        case building
        case floor
        case apartment
        case specialMark = "special_mark"
        case status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case cityName = "city_name"
        case stateName = "state_name"
    }
    var id: Int?
    var userId: Int?
    var fullName: String?
    var phone: String?
    var phoneEx: String?
    var stateId: Int?
    var cityId: Int?
    var building: Int?
    var specialMark: String?
    var floor: Int?
    var status: Int?
    var apartment: Int?
    var cityName: String?
    var street: String?
    var createdAt: String?
    var updatedAt: String?
    var stateName: String?

    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.specialMark) {
            specialMark = String(value)
        }else if let value = try? container.decode(String.self, forKey:.specialMark) {
            specialMark = value
        }
        if let value = try? container.decode(String.self, forKey:.cityId) {
            cityId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.cityId) {
            cityId = value
        }
        if let value = try? container.decode(String.self, forKey:.status) {
            status = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(String.self, forKey:.userId) {
            userId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.userId) {
            userId = value
        }
        if let value = try? container.decode(String.self, forKey:.apartment) {
            apartment = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.apartment) {
            apartment = value
        }
        if let value = try? container.decode(String.self, forKey:.floor) {
            floor = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.floor) {
            floor = value
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(String.self, forKey:.building) {
            building = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.building) {
            building = value
        }
        if let value = try? container.decode(String.self, forKey:.stateId) {
            stateId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.stateId) {
            stateId = value
        }
        if let value = try? container.decode(Int.self, forKey:.phone) {
            phone = String(value)
        }else if let value = try? container.decode(String.self, forKey:.phone) {
            phone = value
        }
        if let value = try? container.decode(Int.self, forKey:.street) {
            street = String(value)
        }else if let value = try? container.decode(String.self, forKey:.street) {
            street = value
        }
        if let value = try? container.decode(Int.self, forKey:.updatedAt) {
            updatedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.updatedAt) {
            updatedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.phoneEx) {
            phoneEx = String(value)
        }else if let value = try? container.decode(String.self, forKey:.phoneEx) {
            phoneEx = value
        }
        if let value = try? container.decode(Int.self, forKey:.fullName) {
            fullName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.fullName) {
            fullName = value                                                                                     
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.cityName) {
            cityName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.cityName) {
            cityName = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.stateName) {
            stateName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.stateName) {
            stateName = value
        }
    }
    
}

