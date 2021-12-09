//
//  ContactUs.swift
//
//  Created by osamaaassi on 07/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ContactUs: Codable {
    
    enum CodingKeys: String, CodingKey {
        case email
        case whatsapp
    }
    
    var email: Email?
    var whatsapp: Whatsapp?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try container.decodeIfPresent(Email.self, forKey: .email)
        whatsapp = try container.decodeIfPresent(Whatsapp.self, forKey: .whatsapp)
    }
    
}
