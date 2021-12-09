//
//  Products.swift
//  Forbrands
//
//  Created by osamaaassi on 07/12/2021.
//

import Foundation

struct Products: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case oldprice
        case amount
     
    }
    var name: String?
    var price: Int?
    var oldprice: Int?
    var amount: Int?

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.price) {
            price = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.price) {
            price = value
        }
        if let value = try? container.decode(Int.self, forKey:.name) {
            name = String(value)
        }else if let value = try? container.decode(String.self, forKey:.name) {
            name = value
        }
        if let value = try? container.decode(String.self, forKey:.oldprice) {
            oldprice = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.oldprice) {
            oldprice = value
        }
        if let value = try? container.decode(String.self, forKey:.amount) {
            amount = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.amount) {
            amount = value
        }
       
    }
    
}
