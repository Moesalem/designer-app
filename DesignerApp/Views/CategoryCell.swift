//
//  CategoryCell.swift
//  DesignerApp
//
//  Created by Moe on 01/05/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    
    var category: Category! {
        didSet{
            categoryImage.kf.indicatorType = .activity
            categoryImage.kf.setImage(with: URL(string: category.imgUrl), options: [.transition(.fade(0.2))])
            categoryLabel.text  = category.name
        }
    }
    
    var categoryImage = UIImageView(image: #imageLiteral(resourceName: "DumbiPic"))
    let categoryLabel = UILabel(text: "Banners", font: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    let shadowView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8

        // UI Setup
        categoryImage.contentMode = .scaleAspectFill
        categoryImage.clipsToBounds = true
        categoryImage.layer.cornerRadius = 8
        categoryImage.alpha = 0.6
        
        categoryLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        categoryLabel.textAlignment = .center
        
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        shadowView.clipsToBounds = true
        
        // Layout
        addSubview(shadowView)
        shadowView.addSubview(categoryImage)
        shadowView.addSubview(categoryLabel)
        
        shadowView.fillSuperview()
        categoryImage.fillSuperview()

        categoryLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
