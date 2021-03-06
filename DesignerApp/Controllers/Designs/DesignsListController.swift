//
//  DesignsListController.swift
//  DesignerApp
//
//  Created by Moe on 01/05/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher

class DesignsListController: MainListController, ProductCellDelegate {
    
    // MARK: - Properties
    
    let desingCellId = "desingCellId"
    
    var products = [Product]()
    
    var category: Category?
    
    fileprivate var listener: ListenerRegistration!
    
    var isFavorite = false
        
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        collectionView.register(DesignCell.self, forCellWithReuseIdentifier: desingCellId)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDesigns()
        print(isFavorite)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        listener.remove()
        products.removeAll()
        collectionView.reloadData()
    }
    
    func productFavorited(product: Product) {
        if UserService.shared.isGuest {
            simpleAlert(title: "Error", msg: "")
        } else {
            UserService.shared.productFavSelected(product: product)
            guard let index = products.firstIndex(of: product) else { return }
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}

// MARK: - DataSource & Delegates
extension DesignsListController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: desingCellId, for: indexPath) as! DesignCell
        let product = products[indexPath.item]
        cell.product = product
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let designDetailController = DesignDetailController()
        let selectedProduct = products[indexPath.item]
        designDetailController.product = selectedProduct
        designDetailController.navigationItem.title = selectedProduct.name
        self.navigationController?.pushViewController(designDetailController, animated: true)
    }
}

// MARK: - Delegate Flow Layout
extension DesignsListController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftRightPadding = view.frame.width  * 0.02.adjusted
        let interSpacing = view.frame.width * 0.02.adjusted
        let cellWidth = (view.frame.width - 2 * leftRightPadding - 2 * interSpacing) / 2
        // print(cellWidth)
        return .init(width: cellWidth, height: cellWidth + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftRightPadding = view.frame.width  * 0.02
        // print(leftRightPadding)
        return .init(top: 20.adjusted, left: leftRightPadding.adjusted, bottom: 20.adjusted, right: leftRightPadding.adjusted)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let interSpacing = view.frame.width * 0.02
        return interSpacing.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.adjusted
    }
}

extension DesignsListController {
    
    
    // TODO: Match the product model in Firebase to Product.swift
    func fetchDesigns() {
        
        guard let category = category else { return }
        
        var query: Query!
        print(isFavorite)
//        if isFavorite {
//            query = Firestore.firestore().collection("users").document(UserService.shared.user.id).collection("favorites")
//            
//        } else {
//            query = Firestore.firestore().products.whereField("category", isEqualTo: category.id)
//        }
        query = Firestore.firestore().collection("users").document(UserService.shared.user.id).collection("favorites")
        
        listener = query.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error Retrieving Data from firestore: ", error)
            }
            snapshot?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let product = Product.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                @unknown default:
                    fatalError()
                }
            })
        }
    }
    
    fileprivate func onDocumentAdded(change: DocumentChange, product: Product) {
        let newIndex = Int(change.newIndex)
        products.insert(product, at: newIndex)
        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    
    fileprivate func onDocumentModified(change: DocumentChange, product: Product) {
        if change.newIndex == change.oldIndex {
            // Item changed but remained in the same position
            let newIndex = Int(change.newIndex)
            products[newIndex] = product
            collectionView.reloadItems(at: [IndexPath(item: newIndex, section: 0)])
        } else  {
            // Item changed and changed position
            let newIndex = Int(change.newIndex)
            let oldIndex = Int(change.oldIndex)
            
            products.remove(at: oldIndex)
            products.insert(product, at: newIndex)
            
            // Move item from oldIndex to newIndex
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
    }
    
    fileprivate func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        products.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
        
    }
}
