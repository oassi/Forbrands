//
//  Favorite.swift
//
//  Created by osamaaassi on 12/12/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct StorePolicy: Codable {
    
    enum CodingKeys: String, CodingKey {
      
        case storePolicy = "store_policy"
        
    }
    
   
    var storePolicy: String?
  
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        
        if let value = try? container.decode(Int.self, forKey:.storePolicy) {
            storePolicy = String(value)
        }else if let value = try? container.decode(String.self, forKey:.storePolicy) {
            storePolicy = value
        }
    }
    
}
