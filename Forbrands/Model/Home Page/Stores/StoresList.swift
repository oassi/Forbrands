//
//  StoresList.swift
//
//  Created by osamaaassi on 23/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct StoresList: Codable {
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
        case status
        case title
    }
    
    var code: Int?
    var message: String?
    var data: [Data]?
    var status: String?
    var title: String?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.code) {
            code = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.code) {
            code = value
        }
        if let value = try? container.decode(Int.self, forKey:.message) {
            message = String(value)
        }else if let value = try? container.decode(String.self, forKey:.message) {
            message = value
        }
        data = try container.decodeIfPresent([Data].self, forKey: .data)
        if let value = try? container.decode(Int.self, forKey:.status) {
            status = String(value)
        }else if let value = try? container.decode(String.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(Int.self, forKey:.title) {
            title = String(value)
        }else if let value = try? container.decode(String.self, forKey:.title) {
            title = value
        }
    }
    
}
