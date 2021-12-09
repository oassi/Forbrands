//
//  AboutApp.swift
//  Forbrands
//
//  Created by osamaaassi on 26/08/2021.
//

import Foundation



struct InfoApp: Codable {
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case errors
        case message
        case data
    }
    
    var code: Int?
    var status: Bool?
    var errors: String?
    var message: String?
    var data: AboutApp?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.code) {
            code = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.code) {
            code = value
        }
        status = try container.decodeIfPresent(Bool.self, forKey: .status)
        if let value = try? container.decode(Int.self, forKey:.errors) {
            errors = String(value)
        }else if let value = try? container.decode(String.self, forKey:.errors) {
            errors = value
        }
        if let value = try? container.decode(Int.self, forKey:.message) {
            message = String(value)
        }else if let value = try? container.decode(String.self, forKey:.message) {
            message = value
        }
        data = try container.decodeIfPresent(AboutApp.self, forKey: .data)
    }
    
}
