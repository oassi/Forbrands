//
//  CustomerOrders.swift
//
//  Created by osamaaassi on 18/09/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct CustomerOrders: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "order_id"
        case orderDate = "order_date"
        case orderProcess = "order_process"
        case totalOldPrice = "total_old_price"
        case totalPrice = "total_price"
        case userId = "user_id"
        case currencyId = "currency_id"
        case addressId = "address_id"
        case deliverDate = "deliver_date"
        case deliveryPrice = "delivery_price"
        case payMethodId = "pay_method_id"
        case status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case payMethod = "pay_method"
        case products
        case reviews
        case address
       
        
    }
    var id: Int?
    var orderId: String?
    var orderProcess: String?
    var deliveryPrice: String?
    var totalOldPrice :Int?
    var addressId:Int?
    var payMethodId: Int?
    var status: Int?
    var userId: Int?
    var updatedAt: String?
    var createdAt: String?
    var deliverDate: String?
    var orderDate: String?
    var totalPrice: String?
    var currencyId: Int?
    var payMethod: PayMethod?
    var products: [Product]?
    var reviews: Reviews?
    var address : AddressList?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        
        if let value = try? container.decode(String.self, forKey:.totalOldPrice) {
            totalOldPrice = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.totalOldPrice) {
            totalOldPrice = value
        }
        
        if let value = try? container.decode(Int.self, forKey:.deliveryPrice) {
            deliveryPrice = String(value)
        }else if let value = try? container.decode(String.self, forKey:.deliveryPrice) {
            deliveryPrice = value
        }
        
        if let value = try? container.decode(String.self, forKey:.payMethodId) {
            payMethodId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.payMethodId) {
            payMethodId = value
        }
        if let value = try? container.decode(String.self, forKey:.addressId) {
            addressId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.addressId) {
            addressId = value
        }
        if let value = try? container.decode(String.self, forKey:.status) {
            status = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.status) {
            status = value
        }
        if let value = try? container.decode(String.self, forKey:.userId) {
            userId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.userId) {
            userId = value
        }
        
        

        if let value = try? container.decode(Int.self, forKey:.orderId) {
            orderId = String(value)
        }else if let value = try? container.decode(String.self, forKey:.orderId) {
            orderId = value
        }
        if let value = try? container.decode(Int.self, forKey:.updatedAt) {
            updatedAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.updatedAt) {
            updatedAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.createdAt) {
            createdAt = String(value)
        }else if let value = try? container.decode(String.self, forKey:.createdAt) {
            createdAt = value
        }
        if let value = try? container.decode(Int.self, forKey:.orderProcess) {
            orderProcess = String(value)
        }else if let value = try? container.decode(String.self, forKey:.orderProcess) {
            orderProcess = value
        }
        if let value = try? container.decode(Int.self, forKey:.deliverDate) {
            deliverDate = String(value)
        }else if let value = try? container.decode(String.self, forKey:.deliverDate) {
            deliverDate = value
        }
        if let value = try? container.decode(Int.self, forKey:.orderDate) {
            orderDate = String(value)
        }else if let value = try? container.decode(String.self, forKey:.orderDate) {
            orderDate = value
        }
        if let value = try? container.decode(Int.self, forKey:.totalPrice) {
            totalPrice = String(value)
        }else if let value = try? container.decode(String.self, forKey:.totalPrice) {
            totalPrice = value
        }
        if let value = try? container.decode(String.self, forKey:.currencyId) {
            currencyId = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.currencyId) {
            currencyId = value
        }
        payMethod = try container.decodeIfPresent(PayMethod.self, forKey: .payMethod)
        products = try container.decodeIfPresent([Product].self, forKey: .products)
        reviews = try container.decodeIfPresent(Reviews.self, forKey: .reviews)
        address = try container.decodeIfPresent(AddressList.self, forKey: .address)
    }
    
}
