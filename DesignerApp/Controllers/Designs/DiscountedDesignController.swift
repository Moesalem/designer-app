//
//  DiscountedDesignController.swift
//  DesignerApp
//
//  Created by Moe on 03/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class DiscountedDesignController: MainListController {
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = false
        collectionView.bounces = false
    }
}

// MARK: - DataSource & Delegates

extension DiscountedDesignController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .yellow
        cell.layer.cornerRadius = 8
        return cell
    }
}

// MARK: - Delegate Flow Layout

extension DiscountedDesignController: UICollectionViewDelegateFlowLayout {
    
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
