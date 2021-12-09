//
//  AboutApp.swift
//  Forbrands
//
//  Created by osamaaassi on 26/08/2021.
//

import Foundation

struct AboutApp: Codable {
    
    enum CodingKeys: String, CodingKey {
        case valueInfo = "value"
       
    }
    var valueInfo: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.valueInfo) {
            valueInfo = String(value)
        }else if let value = try? container.decode(String.self, forKey:.valueInfo) {
            valueInfo = value
        }
    }
    
}
