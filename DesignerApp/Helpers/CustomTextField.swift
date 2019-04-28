//
//  CustomTextField.swift
//  DesignerApp
//
//  Created by Moe on 27/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//


import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    
    private func setUpField() {
        tintColor             = .white
        textColor             = .darkGray
        font                  = UIFont(name: "hey", size: 18.adjusted)
        backgroundColor       = UIColor(white: 1.0, alpha: 0.5)
        autocorrectionType    = .no
//        layer.cornerRadius    = 10
        borderStyle = .roundedRect
        clipsToBounds         = true
        
//        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
//        let placeholderFont   = UIFont.systemFont(ofSize: 10)
//        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
//            [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
//             NSAttributedString.Key.font: placeholderFont])
//
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView              = indentView
        leftViewMode          = .always
    }
}
