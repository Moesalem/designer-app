//
//  CategoryViewControllerController.swift
//  DesignerApp
//
//  Created by Moe on 01/05/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import Firebase

class CategoryViewController: MainListController {
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    fileprivate var categories = [Category]()
    
    // To track the listener
    fileprivate var listener: ListenerRegistration!
    
    // Login/Logout Button
    fileprivate let leftBarBtn = UIBarButtonItem()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        
        self.navigationItem.leftBarButtonItem = leftBarBtn
        leftBarBtn.action = #selector(signInOutBtn)
        leftBarBtn.target = self
    }
    
    //MARK:- viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        setCategoriesListener()
        
        userState()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        listener.remove() // stops realtime updates
        categories.removeAll()
        collectionView.reloadData()
    }
}


// MARK: - DataSource & Delegates
extension CategoryViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        let category = categories[indexPath.item]
        cell.category = category
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let designsListController = DesignsListController()
        
        self.navigationController?.pushViewController(designsListController, animated: true)
    }
}

// MARK: - Delegate Flow Layout
extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftRightPadding = view.frame.width  * 0.02
        let interSpacing = view.frame.width * 0.02
        let cellWidth = (view.frame.width - 2 * leftRightPadding - 2 * interSpacing) / 2
        print(cellWidth)
        return .init(width: cellWidth, height: cellWidth - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftRightPadding = view.frame.width  * 0.02
        print(leftRightPadding)
        return .init(top: 20, left: leftRightPadding, bottom: 10, right: leftRightPadding)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let interSpacing = view.frame.width * 0.02
        return interSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - Firebase Authentication Proccess
extension CategoryViewController {
    
    fileprivate func anonymousUserSignIn() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (res, error) in
                if let error = error {
                    debugPrint("Error Signing in as anonymous", error.localizedDescription)
                }
                print("success")
            }
        }
    }
    
    @objc func signInOutBtn() {
        
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            present(StartupViewController(), animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                print("Logout Successfully")
                anonymousUserSignIn()
            } catch {
                debugPrint("Error Signing out user: ", error.localizedDescription)
            }
        }
    }
    
    fileprivate func userState() {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            leftBarBtn.title = "Logout"
        } else {
            leftBarBtn.title = "Login"
        }
    }
}

// MARK: - Firestore
extension CategoryViewController {
    
    func setCategoriesListener() {
       
        let collection = Firestore.firestore().collection("categories")
        
        listener = collection.addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                print("Error: Listener: ", error.localizedDescription)
            }
            
            snapshot?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let category = Category(data: data)
                
                switch change.type {
                case .added:
                   self.onDocumentAdded(change: change, category: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            })
        }
    }
    
    func onDocumentAdded(change: DocumentChange, category: Category) {
        let newIndex = Int(change.newIndex)
        categories.insert(category, at: newIndex)
        collectionView.insertItems(at:[IndexPath(item: newIndex, section: 0)])
    }
    
    func onDocumentModified(change: DocumentChange, category: Category) {
        if change.newIndex == change.oldIndex {
            // Item changed but remained in the same position
            let newIndex = Int(change.newIndex)
            categories[newIndex] = category
            collectionView.reloadItems(at: [IndexPath(item: newIndex, section: 0)])
        } else  {
            // Item changed and changed position
            let newIndex = Int(change.newIndex)
            let oldIndex = Int(change.oldIndex)
            
            categories.remove(at: oldIndex)
            categories.insert(category, at: newIndex)
            
            // Move item from oldIndex to newIndex
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        categories.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
}
