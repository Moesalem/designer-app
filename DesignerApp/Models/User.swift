//
//  User.swift
//  DesignerApp
//
//  Created by Moe on 09/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import Foundation


struct User {
    let id, email, username, stripId: String
    
    init(id:String="", email:String="", username:String="", stripId:String="") {
        self.id = id
        self.email = email
        self.username = username
        self.stripId = stripId
    }
    
    init(data: [String: Any]) {
           self.id = data["id"] as? String ?? ""
           self.email = data["email"] as? String ?? ""
           self.username = data["username"] as? String ?? ""
           self.stripId = data["stripId"] as? String ?? ""
      }
    
    static func modelToData(user: User) -> [String:Any] {
        let data: [String:Any] = [
            "id": user.id,
            "email": user.email,
            "username": user.username,
            "stripId": user.stripId
        ]
        
        return data
    }
}
