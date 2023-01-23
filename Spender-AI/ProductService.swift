//
//  ProductService..swift
//  Spender-AI
//
//  Created by Stephen Jones on 1/16/23.
//

import Foundation

class ProductService {
    static let shared = ProductService()
    var products: [Product] = []
    
    func loadProducts() {
        // Get the url of the json file
        let url = Bundle.main.url(forResource: "FashionNova-Dresses", withExtension: "json")!
        do {
            // Get the data from the json file
            let data = try Data(contentsOf: url)
            // Use JSONDecoder to decode the data into a dictionary
            let jsonDictionary = try JSONDecoder().decode([String: [Product]].self, from: data)
            // Get the array of products from the dictionary
            products = jsonDictionary["products"] ?? []
        } catch {
            print("Error: Unable to load products from json file. \(error)")
        }
    }
}


