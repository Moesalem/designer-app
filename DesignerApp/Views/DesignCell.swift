//
//  DesignCell.swift
//  DesignerApp
//
//  Created by Moe on 11/05/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class DesignCell: UICollectionViewCell {
    
    
    var designImage = UIImageView(image: #imageLiteral(resourceName: "Rectangle"))
    let designLabel = UILabel(text: "Banners", font: .boldSystemFont(ofSize: 24.adjusted))
    let shadowView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UI Setup
        designImage.contentMode = .scaleAspectFill
        designImage.clipsToBounds = true
        designImage.layer.cornerRadius = 8.adjusted
        
        designLabel.textColor = .white
        designLabel.textAlignment = .center
        
        shadowView.layer.cornerRadius = 8.adjusted
        shadowView.layer.shadowRadius = 8.adjusted
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        
        addSubview(shadowView)
        shadowView.addSubview(designImage)
        shadowView.fillSuperview()
        designImage.fillSuperview()
        shadowView.addSubview(designLabel)
        
        designLabel.anchor(top: nil, leading: shadowView.leadingAnchor, bottom: shadowView.bottomAnchor, trailing: shadowView.trailingAnchor)
        designLabel.constrainHeight(constant: 50.adjusted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
