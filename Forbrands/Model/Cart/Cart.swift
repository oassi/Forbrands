//
//  Cart.swift
//  Forbrands
//
//  Created by osamaaassi on 06/12/2021.
//

import Foundation

struct Cart: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case name
        case category
        case price
        case oldPrice = "old_price"
        case discount
        case quantity
        case total
        case images
    }
    var id: Int?
    var productId: Int?
    var name: String?
    var category: String?
    var price :Int?
    var oldPrice:Int?
    var discount: Int?
    var quantity: Int?
    var total: Int?
    var images: [String]?
    

    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(String.self, forKey:.productId) {
            productId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.productId) {
            productId = value
        }
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.category) {
            category = String(value)
        }else if let value = try? container.decode(String.self, forKey:.category) {
            category = value
        }
        
        if let value = try? container.decode(String.self, forKey:.price) {
            price = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.price) {
            price = value
        }
        if let value = try? container.decode(String.self, forKey:.oldPrice) {
            oldPrice = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.oldPrice) {
            oldPrice = value
        }
        if let value = try? container.decode(String.self, forKey:.discount) {
            discount = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.discount) {
            discount = value
        }
        if let value = try? container.decode(String.self, forKey:.quantity) {
            quantity = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.quantity) {
            quantity = value
        }
        if let value = try? container.decode(String.self, forKey:.total) {
            total = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.total) {
            total = value
        }
        images = try container.decodeIfPresent([String].self, forKey: .images)
    }
    
}
