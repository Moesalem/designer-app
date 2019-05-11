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
    var timeStamp: Timestamp
    var stock: Int
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.category = data["category"] as? String ?? ""
        self.price = data["price"] as? Double ?? 9.99
        self.stock = data["stock"] as? Int ?? 1
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.timeStamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
}
