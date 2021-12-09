//
//  Data.swift
//
//  Created by osamaaassi on 27/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Subscription: Codable {
    
    enum CodingKeys: String, CodingKey {
        case image
        case currency
        case featuresAr = "features_ar"
        case currencyId = "currency_id"
        case featuresEn = "features_en"
        case price
    }
    
    var image: String?
    var currency: Currency?
    var featuresAr: [String]?
    var currencyId: Int?
    var featuresEn: [String]?
    var price: String?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.image) {
            image = String(value)
        }else if let value = try? container.decode(String.self, forKey:.image) {
            image = value
        }
        currency = try container.decodeIfPresent(Currency.self, forKey: .currency)
      
//        if let value = try? container.decode(Int.self, forKey:.featuresAr) {
//            featuresAr = String(value)
//        }else if let value = try? container.decode([String].self, forKey:.featuresAr) {
//            featuresAr = value
//        }
        
        featuresAr = try container.decodeIfPresent([String].self, forKey: .featuresAr)
        featuresEn = try container.decodeIfPresent([String].self, forKey: .featuresEn)
        
        if let value = try? container.decode(String.self, forKey:.currencyId) {
            currencyId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.currencyId) {
            currencyId = value
        }
//        if let value = try? container.decode(Int.self, forKey:.featuresEn) {
//            featuresEn = String(value)
//        }else if let value = try? container.decode(String.self, forKey:.featuresEn) {
//            featuresEn = value
//        }
        if let value = try? container.decode(Int.self, forKey:.price) {
            price = String(value)
        }else if let value = try? container.decode(String.self, forKey:.price) {
            price = value
        }
    }
    
}
