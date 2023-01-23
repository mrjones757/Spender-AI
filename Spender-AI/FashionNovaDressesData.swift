//
//  FashionNovaDressesData.swift
//  Spender-AI
//
//  Created by Stephen Jones on 1/16/23.
//

import Foundation

struct Product: Decodable {
    let name: String
    let price: String
    let imageUrl: String
    let productUrl: String

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case price = "price"
        case imageUrl = "imageUrl"
        case productUrl = "productUrl"
    }
}

struct ProductsContainer: Decodable {
    var products: [Product]
}

