//
//  Currency.swift
//
//  Created by osamaaassi on 27/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Currency: Codable {

  enum CodingKeys: String, CodingKey {
    case shortNameAr = "short_name_ar"
    case shortNameEn = "short_name_en"
    case name
  }

  var shortNameAr: String?
  var shortNameEn: String?
  var name: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let value = try? container.decode(Int.self, forKey:.shortNameAr) {                       
shortNameAr = String(value)                                                                                     
}else if let value = try? container.decode(String.self, forKey:.shortNameAr) {
 shortNameAr = value                                                                                     
}
    if let value = try? container.decode(Int.self, forKey:.shortNameEn) {                       
shortNameEn = String(value)                                                                                     
}else if let value = try? container.decode(String.self, forKey:.shortNameEn) {
 shortNameEn = value                                                                                     
}
    if let value = try? container.decode(Int.self, forKey:.name) {                       
name = String(value)                                                                                     
}else if let value = try? container.decode(String.self, forKey:.name) {
 name = value                                                                                     
}
  }

}
