//
//  DesignCell.swift
//  DesignerApp
//
//  Created by Moe on 11/05/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

protocol ProductCellDelegate: class {
    func productFavorited(product: Product)
}

class DesignCell: UICollectionViewCell {
    
    
    var product: Product! {
        didSet {
            designLabel.text = product.name
            designImage.kf.setImage(with: URL(string: product.imgUrl), options: [.transition(.fade(0.2))])
            designImage.kf.indicatorType = .activity
            
            if UserService.shared.favoriteProducts.contains(product) {
                favBtn.setTitle("Starred", for: .normal)
            } else {
                favBtn.setTitle("Nope", for: .normal)
            }
        }
    }
    
    var designImage = UIImageView()
    let designLabel = UILabel(text: "Banners", font: .boldSystemFont(ofSize: 24.adjusted))
    let shadowView = UIView()
    let favBtn = UIButton(type: .system)
    
    weak var delegate: ProductCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UI Setup
        designImage.contentMode = .scaleAspectFill
        designImage.clipsToBounds = true
        designImage.layer.cornerRadius = 8.adjusted
        
        designLabel.textColor = .white
        designLabel.textAlignment = .center
        
        favBtn.constrainHeight(constant: 50)
        favBtn.constrainWidth(constant: 50)
        favBtn.setTitle("Fav", for: .normal)
        favBtn.backgroundColor = .cyan
        favBtn.addTarget(self, action: #selector(favBtnClicked), for: .touchUpInside)
        
        shadowView.layer.cornerRadius = 8.adjusted
        shadowView.layer.shadowRadius = 8.adjusted
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.4
        
        addSubview(shadowView)
        shadowView.addSubview(designImage)
        addSubview(favBtn)
        
        shadowView.fillSuperview()
        designImage.fillSuperview()
        favBtn.centerXInSuperview()
        designLabel.constrainHeight(constant: 50.adjusted)

    }

    @objc func favBtnClicked() {
        delegate?.productFavorited(product: product)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
