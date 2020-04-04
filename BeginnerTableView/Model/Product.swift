//
//  Product.swift
//  BeginnerTableView
//
//  Created by Sebastian Giurgiu on 01/04/2020.
//  Copyright © 2020 Sean Allen. All rights reserved.
//



struct Product: Equatable {
    var productNumber: Int
    var name: String
    var price: Double
    
}

func ==(lhs: Product, rhs: Product) -> Bool {
    return lhs.name == rhs.name
}


func generateProductName() -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  return String((0..<5).map{ _ in letters.randomElement()! })
}


func generateNewProduct() -> Product {

    var p = Product(productNumber: 0, name: "", price: 0)
    
    let name = generateProductName()
    p.name = name
    
    let price = Double.random(in: 0.1...999.9)
    p.price = price
    
    
    return p
}

func createProductsArray() -> [Product] {
    
  var products: [Product] = []
   
    var nrOfProducts = 1
    while nrOfProducts <= 21 {
        var p = generateNewProduct()
            if !products.contains(p) {
                p.productNumber = nrOfProducts
                products.append(p)
                nrOfProducts += 1
            }
        }
    
  return products
}




