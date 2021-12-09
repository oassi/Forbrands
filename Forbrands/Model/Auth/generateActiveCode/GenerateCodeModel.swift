//
//  GenerateCodeModel.swift
//  Forbrands
//
//  Created by osamaaassi on 26/08/2021.
//

import Foundation

struct GenerateCodeModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case title
        case message
        case data
       
        
       
    }
    
    var code: Int?
    var status: Bool?
    var title: String?
    var message: String?
    var data: GenerateCode?
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey:.code) {
            code = Int(value)
        } else if let value = try? container.decode(Int.self, forKey:.code) {
            code = value
        }
        status = try container.decodeIfPresent(Bool.self, forKey: .status)
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
        data = try container.decodeIfPresent(GenerateCode.self, forKey: .data)
    }
    
}
