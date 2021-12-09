//
//  Pivot.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Pivot: Codable {

  enum CodingKeys: String, CodingKey {
    case modelType = "model_type"
    case modelId = "model_id"
    case roleId = "role_id"
  }

  var modelType: String?
  var modelId: Int?
  var roleId: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let value = try? container.decode(Int.self, forKey:.modelType) {                       
modelType = String(value)                                                                                     
}else if let value = try? container.decode(String.self, forKey:.modelType) {
 modelType = value                                                                                     
}
    if let value = try? container.decode(String.self, forKey:.modelId) {
 modelId = Int(value)                                                                                     
} else if let value = try? container.decode(Int.self, forKey:.modelId) {
modelId = value 
}
    if let value = try? container.decode(String.self, forKey:.roleId) {
 roleId = Int(value)                                                                                     
} else if let value = try? container.decode(Int.self, forKey:.roleId) {
roleId = value 
}
  }

}
