//
//  ExploreViewController.swift
//  DesignerApp
//
//  Created by Moe on 25/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//
//
import UIKit

class ExploreController: MainListController {
    
    // MARK: - Properties
    
    fileprivate let categoryCellId = "cellId"
    fileprivate let featureDesignCellId = "featureDesignCellId"
    var categoryVC = CategoryController()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        collectionView.register(CategoryGroupCell.self, forCellWithReuseIdentifier: categoryCellId)
        collectionView.register(FeaturedDesignGroupCell.self, forCellWithReuseIdentifier: featureDesignCellId)
    }
}

// MARK: - DataSource & Delegates

extension ExploreController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryGroupCell
            cell.categoryViewController.didSelectHandler = { selectedCategory in
                let designsListController = DesignsListController()
                designsListController.category = selectedCategory
                designsListController.navigationItem.title = selectedCategory.name
                self.navigationController?.pushViewController(designsListController, animated: true)
            }
            cell.categoryViewController.setCategoriesListener()
            cell.categoryViewController.collectionView.reloadData()
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featureDesignCellId, for: indexPath) as! FeaturedDesignGroupCell
            
            cell.featuredDesignController.didSelectProductHandler = { selectedProduct in
                let designDetailController = DesignDetailController()
                designDetailController.product = selectedProduct
                designDetailController.navigationItem.title = selectedProduct.name
                self.navigationController?.pushViewController(designDetailController, animated: true)

            }
            cell.featuredDesignController.fetchFeaturedDesigns()
            cell.featuredDesignController.listener.remove()
//            cell.featuredDesignController.products.removeAll() // confused
            cell.featuredDesignController.collectionView.reloadData()
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - Delegate Flow Layout

extension ExploreController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return .init(width: view.frame.width, height: 250)
        } else {
            return .init(width: view.frame.width, height: 350)
        }
    }
}
