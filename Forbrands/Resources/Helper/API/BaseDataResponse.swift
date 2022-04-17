//
//  BaseDataResponse.swift
//  BayanPay
//
//  Created by user on 31/07/20.
//  Copyright © 2020 Lucky Lakhwani. All rights reserved.
//

import Foundation


struct BaseDataResponse<T:Codable>: Codable {
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case title
        case message
        case data
        case errors
        
    }
    
    var status: Bool?
    var code: Int?
    var title: String?
    var message: String?
    var errors:[String]?
    var data: T?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(Bool.self, forKey: .status)
        
        if let value = try? container.decode(String.self, forKey:.code) {
            code = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.code) {
            code = value
        }
        if let value = try? container.decode(Int.self, forKey:.title) {
            title = String(value)
        }else if let value = try? container.decode(String.self, forKey:.title) {
            title = value
        }
        if let value = try? container.decode(Int.self, forKey:.message) {
            message = String(value)
        }else if let value = try? container.decode(String.self, forKey:.message) {
            message = value
        }
        if let value  =  try container.decodeIfPresent(T.self, forKey: .data){
            data = value
        }else {
            data = nil
        }
        
    }
    
}



struct BaseDataArrayResponse<T:Codable>: Codable {
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case title
        case message
        case data
        
    }
    var status: Bool?
    var code: Int?
    var title: String?
    var message: String?
    var data: [T]?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(Bool.self, forKey: .status)
        if let value = try? container.decode(String.self, forKey:.code) {
            code = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.code) {
            code = value
        }
        if let value = try? container.decode(Int.self, forKey:.title) {
            title = String(value)
        }else if let value = try? container.decode(String.self, forKey:.title) {
            title = value
        }
        if let value = try? container.decode(Int.self, forKey:.message) {
            message = String(value)
        }else if let value = try? container.decode(String.self, forKey:.message) {
            message = value
        }
        if let value  =  try container.decodeIfPresent([T].self, forKey: .data){
            data = value
            
        }else {
            data = nil
        }
       
       
        
    }
    
}
struct BasePagingResponse<T:Codable>: Codable {
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case status
        case code
    }
    
    var message: String?
    var data: itemData<T>?
    var status: Bool?
    var code: Int?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.message) {
            message = String(value)
        }else if let value = try? container.decode(String.self, forKey:.message) {
            message = value
        }
        if let value  =  try container.decodeIfPresent(itemData<T>.self, forKey: .data){
            data = value
            
        }else {
            data = nil
        }
        
        status = try container.decodeIfPresent(Bool.self, forKey: .status)
        if let value = try? container.decode(String.self, forKey:.code) {
            code = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.code) {
            code = value
        }
    }
    
}
struct itemData<T:Codable>: Codable {
    
    enum CodingKeys: String, CodingKey {
        case items
        case paginate
    }
    
    var items: [T]?
    var paginate: paginatePaginate?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value  =  try container.decodeIfPresent([T].self, forKey: .items){
            items = value
            
        }else {
            items = nil
        }
        paginate = try container.decodeIfPresent(paginatePaginate.self, forKey: .paginate)
    }
    
}

struct TabbayResponse:Codable {
    
    enum CodingKeys: String, CodingKey {
        case status
        case webUrl = "web_url"
        
    }
    
    var status: String?
    var webUrl: String?
   
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey:.status) {
            status = String(value)
        }else if let value = try? container.decode(String.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(Int.self, forKey:.webUrl) {
            webUrl = String(value)
        }else if let value = try? container.decode(String.self, forKey:.webUrl) {
            webUrl = value
        }
        
    }
    
}
