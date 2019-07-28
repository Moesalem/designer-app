//
//  FeaturedDesignCell.swift
//  DesignerApp
//
//  Created by Moe on 27/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class FeaturedDesignCell: UICollectionViewCell {
    
    let featureDesignImage = UIImageView(cornerRadius: 8)
    let featureDesignTitle = UILabel(text: "Design Title", font: .boldSystemFont(ofSize: 24), numberOfLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        featureDesignImage.image = UIImage(named: "DumbiPic")
        featureDesignTitle.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.7607843137, blue: 0.1058823529, alpha: 1)
        featureDesignTitle.textAlignment = .center
        addSubview(featureDesignImage)
        featureDesignImage.addSubview(featureDesignTitle)
        
        featureDesignImage.fillSuperview()
        featureDesignTitle.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
