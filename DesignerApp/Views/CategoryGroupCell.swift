//
//  CategoryGroupCell.swift
//  DesignerApp
//
//  Created by Moe on 25/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class CategoryGroupCell: UICollectionViewCell {
    
    let categoryViewController = CategoryViewController()
    
    let label = UILabel(text: "Categories", font: .boldSystemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UI Setup
        
        addSubview(categoryViewController.view)
        addSubview(label)
        
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        categoryViewController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
