//
//  AdminCategoryController.swift
//  DesignerAppAdmin
//
//  Created by Moe on 06/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import Firebase

class AdminCategoryController: MainListController {
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    fileprivate var categories = [Category]()
    
    fileprivate var selectedCategory: Category!
    
    // To track the listener
    fileprivate var listener: ListenerRegistration!
    
    var didSelectHandler: ((Category) -> ())?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(AdminCategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        
        navigationItem.title = "Admin"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goAddCategory))
    }
    
    @objc func goAddCategory(){
        self.navigationController?.pushViewController(AddCategoryController(), animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        setCategoriesListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         listener.remove() // stops realtime updates
        categories.removeAll()
        collectionView.reloadData()
    }
}


// MARK: - DataSource & Delegates
extension AdminCategoryController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AdminCategoryCell
        let category = categories[indexPath.item]
        cell.category = category
        return cell
    }
}

// MARK: - Delegate Flow Layout
extension AdminCategoryController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftRightPadding = view.frame.width  * 0.10
        let interSpacing = view.frame.width * 0.10
        let cellWidth = (view.frame.width - 2 * leftRightPadding - 2 * interSpacing) / 2
//        print(cellWidth)
        return .init(width: cellWidth, height: cellWidth + 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftRightPadding = view.frame.width  * 0.02
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

// MARK: - Firestore
extension AdminCategoryController {
    
    func setCategoriesListener() {

        listener = Firestore.firestore().categoriesByTimestamp.addSnapshotListener { (snapshot, error) in
            
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
                @unknown default:
                    print("Unknown Error")
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
