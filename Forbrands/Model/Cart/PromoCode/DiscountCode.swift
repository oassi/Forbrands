//
//  DiscountCode.swift
//  Forbrands
//
//  Created by osamaaassi on 06/12/2021.
//

import Foundation

struct DiscountCode: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case discount
     
    }
    var id: Int?
    var discount: Int?

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.id) {
            id = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.id) {
            id = value
        }
        if let value = try? container.decode(String.self, forKey:.discount) {
            discount = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.discount) {
            discount = value
        }
       
    }
    
}
