//
//  MyAccount.swift
//
//  Created by osamaaassi on 29/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct MyAccount: Codable {
    
    enum CodingKeys: String, CodingKey {
        case instagram
        case twitter
        case googlePlay = "google-play"
        case appStore  = "app-store"
        case shareText = "share-text"
        case subscriptions
    }
    
    var instagram: String?
    var twitter: String?
    var googlePlay: String?
    var appStore: String?
    var shareText: String?
    var subscriptions: Bool?
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.instagram) {
            instagram = String(value)
        }else if let value = try? container.decode(String.self, forKey:.instagram) {
            instagram = value
        }
        if let value = try? container.decode(Int.self, forKey:.twitter) {
            twitter = String(value)
        }else if let value = try? container.decode(String.self, forKey:.twitter) {
            twitter = value
        }
        if let value = try? container.decode(Int.self, forKey:.googlePlay) {
            googlePlay = String(value)
        }else if let value = try? container.decode(String.self, forKey:.googlePlay) {
            googlePlay = value
        }
        if let value = try? container.decode(Int.self, forKey:.appStore) {
            appStore = String(value)
        }else if let value = try? container.decode(String.self, forKey:.appStore) {
            appStore = value
        }
        if let value = try? container.decode(Int.self, forKey:.shareText) {
            shareText = String(value)
        }else if let value = try? container.decode(String.self, forKey:.shareText) {
            shareText = value
        }
        
        subscriptions = try container.decodeIfPresent(Bool.self, forKey: .subscriptions)
    }
    
}
