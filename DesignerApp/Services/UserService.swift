//
//  Service.swift
//  DesignerApp
//
//  Created by Moe on 09/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    static let shared = UserService()
    
    var user = User()
    let auth = Auth.auth()
    var favoriteProducts = [Product]()
    let db = Firestore.firestore()
    var userListener: ListenerRegistration? = nil
    var favsListener: ListenerRegistration? = nil
    
    
    var isGuest: Bool{
        
        guard let authUser = auth.currentUser else {
            return true
        }
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() {
        guard let authUser = auth.currentUser else { return }
        
        let userRef = db.collection("users").document(authUser.uid)
       
        userListener = userRef.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("Failed to add snapshotlistener!", error)
            }
            guard let data = snapshot?.data() else { return }
            self.user = User.init(data: data)
            print(self.user)
        })
        
        favsListener = userRef.collection("favorites").addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("Failed to add snapshotlistener!", error)
            }
            
            snapshot?.documents.forEach({ (document) in
                let favorite = Product.init(data: document.data())
                self.favoriteProducts.append(favorite)
            })
        })
    }
    
    func productFavSelected(product: Product) {
        let favRef = Firestore.firestore().collection("users").document(user.id).collection("favorites")
        
        if favoriteProducts.contains(product) {
            favoriteProducts.removeAll{ $0 == product }
            favRef.document(product.id).delete()
        } else {
            favoriteProducts.append(product)
            let data = Product.modelToData(product: product)
            favRef.document(product.id).setData(data)
        }
    }
    
    func userLoggedOut () {
        userListener?.remove()
        userListener = nil
        favsListener?.remove()
        favsListener = nil
        user = User()
    }
}
