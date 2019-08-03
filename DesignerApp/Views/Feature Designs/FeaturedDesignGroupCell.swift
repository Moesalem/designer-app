//
//  FeaturedDesignGroupCell.swift
//  DesignerApp
//
//  Created by Moe on 27/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class FeaturedDesignGroupCell: UICollectionViewCell {
    
    let featuredDesignController = FeaturedDesignsController()
    let featuredLabel = UILabel(text: "Featured", font: .boldSystemFont(ofSize: 26))
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        featuredLabel.textColor = #colorLiteral(red: 0.9647058824, green: 0.7607843137, blue: 0.1058823529, alpha: 1)
        // UI Setup
        addSubview(featuredLabel)
        addSubview(featuredDesignController.view)
        
        featuredLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 15, left: 8, bottom: 0, right: 0))
        featuredDesignController.view.anchor(top: featuredLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
