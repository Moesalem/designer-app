//
//  CustomButton.swift
//  DesignerApp
//
//  Created by Moe on 27/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    private func setupButton() {
        backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 0.9079088185)
        titleLabel?.font = UIFont.systemFont(ofSize: 14.adjusted, weight: UIFont.Weight(rawValue: 6.adjusted))
        layer.cornerRadius = 10
//        self÷
        setTitleColor(.white, for: .normal)
    }
}
