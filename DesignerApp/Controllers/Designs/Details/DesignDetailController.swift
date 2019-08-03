//
//  DesignDetailController.swift
//  DesignerApp
//
//  Created by Moe on 29/07/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Kingfisher
class DesignDetailController: UIViewController {
    
    
    //MARK:- Varibales
    var product: Product?
    var designImage = UIImageView()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        setupLayout()
    }
    
    let blackBackgroundView = UIView()
    let newImageView = UIImageView()

    @objc func imageTapped(sender: UITapGestureRecognizer) {
        
        
        if let startingFrame = self.designImage.superview?.convert(self.designImage.frame, to: nil) {
            
            
            designImage = sender.view as! UIImageView
            designImage.alpha = 0
            blackBackgroundView.alpha = 0
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            view.addSubview(blackBackgroundView)
            
            newImageView.image = designImage.image
            newImageView.clipsToBounds = true
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            
            newImageView.frame = startingFrame
            newImageView.layer.cornerRadius = 8
            
            self.view.addSubview(newImageView)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.newImageView.alpha = 1
                self.newImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.blackBackgroundView.alpha = 1
                self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -100)
                self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.newImageView.frame = self.designImage.frame
            self.designImage.alpha = 1
            self.blackBackgroundView.alpha = 0
            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: 0)
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
            
            self.newImageView.alpha = 0
//            sender.view?.removeFromSuperview()
        }, completion: nil)
        
    }
    
    func setupLayout() {
        
        designImage.kf.setImage(with: URL(string: product?.imgUrl ?? ""), options: [.transition(.fade(0.2))])
        designImage.contentMode = .scaleAspectFill
        designImage.clipsToBounds = true
        designImage.layer.cornerRadius = 8
        designImage.backgroundColor = .yellow
        designImage.isUserInteractionEnabled = true
        designImage.constrainHeight(constant: 350)
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        designImage.addGestureRecognizer(tap)
        
        let designName = UILabel(text: product?.name ?? "not found", font: .boldSystemFont(ofSize: 16), numberOfLines: 2)
        //        designName.backgroundColor = .red
        designName.constrainHeight(constant: 50)
        
        let designDescription = UILabel(text: "Design DescriptionDesign DescriptionDesign DescriptionDesign DescriptionDesign DescriptionDesign DescriptionDesign Description", font: .systemFont(ofSize: 14), numberOfLines: 0)
        //        designDescription.backgroundColor = .blue
        //        designDescription.constrainHeight(constant: 100)
        designDescription.sizeToFit()
        let designPrice = UILabel(text: "$\(product?.price ?? 20.99)", font: .boldSystemFont(ofSize: 14))
        //        designPrice.backgroundColor = .green
        designPrice.constrainHeight(constant: 30)
        
        let descriptionStackView = VerticalStackView(arrangedSubviews: [
            designName,
            designDescription,
            designPrice
        ], spacing: 10)
        
        descriptionStackView.distribution = .fill
        descriptionStackView.alignment = .fill
        
        let purchaseBtn = UIButton(type: .system)
        let addToCartBtn = UIButton(type: .system)
        purchaseBtn.layer.cornerRadius = 8
        addToCartBtn.layer.cornerRadius = 8
        
        purchaseBtn.backgroundColor = #colorLiteral(red: 1, green: 0.8076553941, blue: 0.3231929541, alpha: 1)
        purchaseBtn.setTitle("Purchase Button", for: .normal)
        addToCartBtn.backgroundColor = #colorLiteral(red: 0.4207352698, green: 0.7451786399, blue: 1, alpha: 1)
        addToCartBtn.setTitle("Add To Cart Button", for: .normal)
        
        let btnsStackView = VerticalStackView(arrangedSubviews: [
            purchaseBtn,
            addToCartBtn
        ], spacing: 5)
        btnsStackView.distribution = .fillEqually
        btnsStackView.alignment = .fill
        btnsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [
            designImage,
            descriptionStackView
        ], spacing: 12)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        
        view.addSubview(verticalStackView)
        view.addSubview(btnsStackView)
        
        if #available(iOS 11.0, *) {
            verticalStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        } else {
            // Fallback on earlier versions
        }
        
        //        verticalStackView.bottomAnchor.constraint(greaterThanOrEqualTo: btnsStackView.topAnchor, constant: 200).isActive = true
        if #available(iOS 11.0, *) {
            btnsStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 20, right: 10))
            
        } else {
            // Fallback on earlier versions
        }
    }
    
}
