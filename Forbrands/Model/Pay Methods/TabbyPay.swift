//
//  TabbyPay.swift
//  Forbrands
//
//  Created by osamaaassi on 01/12/2021.
//

import Foundation



struct TabbyPay: Codable {
    
    enum CodingKeys: String, CodingKey {

        case webUrl = "web_url"
    }

    var webUrl: String?
  
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.webUrl) {
            webUrl = String(value)
        }else if let value = try? container.decode(String.self, forKey:.webUrl) {
            webUrl = value
        }


        
    }
    
}
