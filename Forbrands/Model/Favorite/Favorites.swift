//
//  Favorites.swift
//  Forbrands
//
//  Created by osamaaassi on 12/12/2021.
//

import Foundation

struct Favorites: Codable {

  enum CodingKeys: String, CodingKey {
    case favorite
    case product
  }

  var favorite: Favorite?
  var product: Product?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    favorite = try container.decodeIfPresent(Favorite.self, forKey: .favorite)
    product = try container.decodeIfPresent(Product.self, forKey: .product)
  }

}
