//
//  paginatePaginate.swift
//
//  Created by Ahmed ios on 28/04/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct paginatePaginate: Codable {
    
    enum CodingKeys: String, CodingKey {
        case from
        case nextPageUrl = "next_page_url"
        case firstPageUrl = "first_page_url"
        case lastPageUrl = "last_page_url"
        case lastPage = "last_page"
        case to
        case prevPageUrl = "prev_page_url"
        case perPage = "per_page"
        case total
        case currentPage = "current_page"
    }
    
    var from: Int?
    var nextPageUrl: String?
    var firstPageUrl: String?
    var lastPageUrl: String?
    var lastPage: Int?
    var to: Int?
    var prevPageUrl: String?
    var perPage: Int?
    var total: Int?
    var currentPage: Int?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.from) {
            from = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.from) {
            from = value
        }
        if let value = try? container.decode(Int.self, forKey:.nextPageUrl) {
            nextPageUrl = String(value)
        }else if let value = try? container.decode(String.self, forKey:.nextPageUrl) {
            nextPageUrl = value
        }
        if let value = try? container.decode(Int.self, forKey:.firstPageUrl) {
            firstPageUrl = String(value)
        }else if let value = try? container.decode(String.self, forKey:.firstPageUrl) {
            firstPageUrl = value
        }
        if let value = try? container.decode(Int.self, forKey:.lastPageUrl) {
            lastPageUrl = String(value)
        }else if let value = try? container.decode(String.self, forKey:.lastPageUrl) {
            lastPageUrl = value
        }
        if let value = try? container.decode(String.self, forKey:.lastPage) {
            lastPage = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.lastPage) {
            lastPage = value
        }
        if let value = try? container.decode(String.self, forKey:.to) {
            to = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.to) {
            to = value
        }
        if let value = try? container.decode(Int.self, forKey:.prevPageUrl) {
            prevPageUrl = String(value)
        }else if let value = try? container.decode(String.self, forKey:.prevPageUrl) {
            prevPageUrl = value
        }
        if let value = try? container.decode(String.self, forKey:.perPage) {
            perPage = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.perPage) {
            perPage = value
        }
        if let value = try? container.decode(String.self, forKey:.total) {
            total = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.total) {
            total = value 
        }
        if let value = try? container.decode(String.self, forKey:.currentPage) {
            currentPage = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.currentPage) {
            currentPage = value
        }
    }
    
}
