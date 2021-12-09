//
//  OrdersComplete.swift
//  Forbrands
//
//  Created by osamaaassi on 07/12/2021.
//

import Foundation
struct OrdersComplete: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "order_id"
        case oldtotal
        case total
        case payment
        case promocode
        case products
        case shoping
     
    }
    var id: Int?
    var discount: Int?
    var total: Int?
    var oldtotal: Int?
    var payment: String?
    var promocode: Int?
    var orderId: String?
    var shoping : String?
    var products: [Products]?
    

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decodeIfPresent([Products].self, forKey: .products)
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(Int.self, forKey:.orderId) {
            orderId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.orderId) {
            orderId = value
        }
        if let value = try? container.decode(Int.self, forKey:.shoping) {
            shoping = String(value)
        }else if let value = try? container.decode(String.self, forKey:.shoping) {
            shoping = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.payment) {
            payment = String(value)
        }else if let value = try? container.decode(String.self, forKey:.payment) {
            payment = value
        }
        if let value = try? container.decode(String.self, forKey:.total) {
            total = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.total) {
            total = value
        }
        if let value = try? container.decode(String.self, forKey:.oldtotal) {
            oldtotal = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.oldtotal) {
            oldtotal = value
        }
        if let value = try? container.decode(String.self, forKey:.promocode) {
            promocode = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.promocode) {
            promocode = value
        }
       
    }
    
}
