//
//  Extensions.swift
//  AppsStore
//
//  Created by Moe on 27/02/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {
 
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.4, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach({addSubview($0)})
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...){
        views.forEach({addArrangedSubview($0)})
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 0){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
}


extension UIImage {
    func withBackground(color: UIColor, opaque: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return self }
        defer { UIGraphicsEndImageContext() }
        
        let rect = CGRect(origin: .zero, size: size)
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
        ctx.draw(cgImage!, in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}

class Device {
    // Base width in point, use iPhone 6
    static let base: CGFloat = 375
    static var ratio: CGFloat {
        return UIScreen.main.bounds.width / base
    }
}

extension CGFloat {
    var adjusted: CGFloat {
        return self * Device.ratio
    }
}
extension Double {
    var adjusted: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}
extension Int {
    var adjusted: CGFloat {
        return CGFloat(self) * Device.ratio
    }
}
