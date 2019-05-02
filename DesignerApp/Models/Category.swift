//
//  Category.swift
//  DesignerApp
//
//  Created by Moe on 01/05/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    let name: String
    let id: String
    let imgUrl: String
    let isActive: Bool
    let timestamp: Timestamp
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp()
    }
}
