//
//  CustomButton.swift
//  DesignerApp
//
//  Created by Moe on 27/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

//class CustomButton: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupButton()
//    }
//
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//    }
//
//
//    private func setupButton() {
//        buttonType = ButtonType.system
//        backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 0.9079088185)
//        titleLabel?.font = UIFont.systemFont(ofSize: 14.adjusted, weight: UIFont.Weight(rawValue: 6.adjusted))
//        layer.cornerRadius = 8
//        setTitleColor(.white, for: .normal)
//    }
//}


class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        backgroundColor      = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 0.9079088185)
        titleLabel?.font     = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius   = 10
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 5
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }   
}