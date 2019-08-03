//
//  DiscountedDesignCell.swift
//  DesignerApp
//
//  Created by Moe on 03/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class DiscountedDesignCell: UICollectionViewCell {
    
    let discountedDesignController = DiscountedDesignController()
    
    let sectionTitle = UILabel(text: "This is Discounted", font: .boldSystemFont(ofSize: 26))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sectionTitle.textColor = #colorLiteral(red: 0.9647058824, green: 0.7607843137, blue: 0.1058823529, alpha: 1)
        addSubview(sectionTitle)
        addSubview(discountedDesignController.view)
        
        sectionTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        discountedDesignController.view.anchor(top: sectionTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
