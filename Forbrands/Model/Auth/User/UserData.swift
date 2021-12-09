//
//  Data.swift
//
//  Created by osamaaassi on 22/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct UserData: Codable {
    
    enum CodingKeys: String, CodingKey {
        case roleName = "role_name"
        case user
        case token
        case store
    }
    
    var user: UserStruct?
    var roleName: String?
    var store: StoreTrader?
    var token: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.roleName) {
            roleName = String(value)
        }else if let value = try? container.decode(String.self, forKey:.roleName) {
            roleName = value
        }
        user = try container.decodeIfPresent(UserStruct.self, forKey: .user)
        if let value = try? container.decode(Int.self, forKey:.token) {
            token = String(value)
        }else if let value = try? container.decode(String.self, forKey:.token) {
            token = value
        }
        store = try container.decodeIfPresent(StoreTrader.self, forKey: .store)
        
    }
    
}
