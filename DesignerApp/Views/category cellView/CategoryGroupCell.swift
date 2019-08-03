//
//  CategoryGroupCell.swift
//  DesignerApp
//
//  Created by Moe on 25/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class CategoryGroupCell: UICollectionViewCell {
    
    let categoryViewController = CategoryController()
    
    let label = UILabel(text: "Categories", font: .boldSystemFont(ofSize: 22))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UI Setup
        label.textColor = #colorLiteral(red: 0.9647058824, green: 0.7607843137, blue: 0.1058823529, alpha: 1)
        addSubview(categoryViewController.view)
        addSubview(label)
        
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 8, bottom: 0, right: 0))
        categoryViewController.view.anchor(top: label.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
