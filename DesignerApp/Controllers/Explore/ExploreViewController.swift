//
//  ExploreViewController.swift
//  DesignerApp
//
//  Created by Moe on 25/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class ExploreViewController: MainListController {
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    
    var categoryVC = CategoryViewController()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        collectionView.register(CategoryGroupCell.self, forCellWithReuseIdentifier: cellId)
        
    }
}

// MARK: - DataSource & Delegates

extension ExploreViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryGroupCell
        cell.categoryViewController.didSelectHandler = { selectedCategory in
            let designsListController = DesignsListController()
            designsListController.category = selectedCategory
            self.navigationController?.pushViewController(designsListController, animated: true)
        }
        cell.categoryViewController.setCategoriesListener()
        cell.categoryViewController.collectionView.reloadData()
        return cell
    }
}

// MARK: - Delegate Flow Layout

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}
