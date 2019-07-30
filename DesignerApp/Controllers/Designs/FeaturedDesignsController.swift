//
//  FeaturedDesignsController.swift
//  DesignerApp
//
//  Created by Moe on 27/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher

class FeaturedDesignsController: HorizontalController {
    
    // MARK: - Properties
    
    fileprivate let featuredCellId = "featuredCellId"
   
    var listener: ListenerRegistration!
    
    var products = [Product]()
    
    var didSelectProductHandler: ((Product) -> ())!
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(FeaturedDesignCell.self, forCellWithReuseIdentifier: featuredCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchFeaturedDesigns()
    }
}

// MARK: - DataSource & Delegates

extension FeaturedDesignsController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredCellId, for: indexPath) as! FeaturedDesignCell
        
        let product = products[indexPath.item]
        
        cell.featureDesignTitle.text = product.name
        cell.featureDesignImage.kf.setImage(with: URL(string: product.imgUrl), options: [.transition(.fade(0.2))])
        cell.featureDesignImage.kf.indicatorType = .activity
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = products[indexPath.item]
        didSelectProductHandler(selectedCell)
    }
}

// MARK: - Delegate Flow Layout

extension FeaturedDesignsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 200, height: 300)
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

extension FeaturedDesignsController {
    
    
    // TODO: Match the product model in Firebase to Product.swift
    func fetchFeaturedDesigns() {
        
        let products = Firestore.firestore().products.whereField("isFeatured", isEqualTo: true)
        
        listener = products.addSnapshotListener { (snapshot, error) in
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
