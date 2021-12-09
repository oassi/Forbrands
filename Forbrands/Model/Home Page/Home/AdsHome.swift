//
//  Ads.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct AdsHome: Codable {
    
    enum CodingKeys: String, CodingKey {
        case position
        case image
        case link
        case id
    }
    
    var position: String?
    var image: String?
    var link: String?
    var id: Int?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.position) {
            position = String(value)
        }else if let value = try? container.decode(String.self, forKey:.position) {
            position = value
        }
        if let value = try? container.decode(Int.self, forKey:.image) {
            image = String(value)
        }else if let value = try? container.decode(String.self, forKey:.image) {
            image = value
        }
        if let value = try? container.decode(Int.self, forKey:.link) {
            link = String(value)
        }else if let value = try? container.decode(String.self, forKey:.link) {
            link = value                                                                                     
        }
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
    }
    
}
