//
//  HomePage.swift
//
//  Created by osamaaassi on 30/08/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct HomePage: Codable {

  enum CodingKeys: String, CodingKey {
    case stores
    case ads
    case storesWithVideo
    case products
    case categories
  }

  var ads: [AdsHome]?
  var stores: [StoresHome]?
  var products: [Product]?
  var storesWithVideo: [StoresWithVideoHome]?
  var categories: [CategoriesHome]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    stores = try container.decodeIfPresent([StoresHome].self, forKey: .stores)
    ads = try container.decodeIfPresent([AdsHome].self, forKey: .ads)
    storesWithVideo = try container.decodeIfPresent([StoresWithVideoHome].self, forKey: .storesWithVideo)
    products = try container.decodeIfPresent([Product].self, forKey: .products)
    categories = try container.decodeIfPresent([CategoriesHome].self, forKey: .categories)
  }

}
