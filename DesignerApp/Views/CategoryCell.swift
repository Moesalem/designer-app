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
    let categoryLabel = UILabel(text: "Banners", font: .boldSystemFont(ofSize: 18), numberOfLines: 2)
    let shadowView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8

        // UI Setup
        categoryImage.contentMode = .scaleAspectFill
        categoryImage.clipsToBounds = true
        categoryImage.layer.cornerRadius = 8
        categoryLabel.textColor = .white
        categoryLabel.textAlignment = .center
        
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        
        categoryLabel.textColor = #colorLiteral(red: 0.8210753798, green: 0.6480794549, blue: 0.08877464384, alpha: 1)
        
        // Layout
        addSubview(shadowView)
        shadowView.addSubview(categoryImage)
        shadowView.addSubview(categoryLabel)
        
        shadowView.fillSuperview()
        categoryImage.fillSuperview()

        categoryLabel.anchor(top: nil, leading: shadowView.leadingAnchor, bottom: shadowView.bottomAnchor, trailing: shadowView.trailingAnchor)
        categoryLabel.constrainHeight(constant: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
