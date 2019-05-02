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

class CategoryViewController: MainListController {
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    fileprivate var categories = [Category]()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        fetchCollection()
    }
    
    func fetchDocument() {
        let doc = Firestore.firestore().collection("categories").document("3c9BBqfkGX6IbW7SxGJV")
        doc.getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else { return }
            let newCategory = Category.init(data: data)
            self.categories.append(newCategory)
            self.collectionView.reloadData()
        }
    }
    
    func fetchCollection() {
        let db = Firestore.firestore()
        let collection = db.collection("categories")
        collection.getDocuments { (snap, error) in
            if let error = error {
                print(error)
            }
            guard let docs = snap?.documents else { return }
            for doc in docs {
                let data = doc.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            self.collectionView.reloadData()
        }
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
        cell.categoryImage.kf.indicatorType = .activity
        cell.categoryImage.kf.setImage(with: URL(string: category.imgUrl), options: [.transition(.fade(0.2))])
        cell.categoryLabel.text  = category.name
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
