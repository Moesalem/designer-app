//
//  Product.swift
//  DesignerApp
//
//  Created by Moe on 01/05/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    var name, id, category, imgUrl: String
    var price: Double
    var timestamp: Timestamp
    var stock: Int
    var isFeatured: Bool
    
    
    init(name: String, id: String, category:String, imgUrl: String, price: Double, timestamp: Timestamp, stock:Int=10, isFeatured:Bool) {
        self.name = name
        self.id = id
        self.category = category
        self.imgUrl = imgUrl
        self.price = price
        self.timestamp = timestamp
        self.stock = stock
        self.isFeatured = isFeatured
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.category = data["category"] as? String ?? ""
        self.price = data["price"] as? Double ?? 9.99
        self.stock = data["stock"] as? Int ?? 1
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
        self.isFeatured = data["isFeatured"] as? Bool ?? false
    }
    
    static func modelToData(product: Product) -> [String:Any] {
        let data: [String:Any]
        data = [
            "name": product.name,
            "id": product.id,
            "category": product.category,
            "imgUrl": product.imgUrl,
            "price": product.price,
            "timestamp": product.timestamp,
            "stock": product.stock,
            "isFeatured": product.isFeatured,
        ]
        return data
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rsh: Product) -> Bool{
        return lhs.id == rsh.id
    }
}
