//
//  ViewController.swift
//  DesignerApp
//
//  Created by Moe on 27/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientBackground(colorOne: #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.03137254902, blue: 0.2666666667, alpha: 1))
        
        setupViews()

    }
    
    
    fileprivate func setupViews() {
        
        // card view
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.dropShadow()
        
        // Username
        let usernameTxtField = CustomTextField()
        usernameTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        usernameTxtField.placeholder = "Username"
        
        // Email
        let emailTxtField = CustomTextField()
        emailTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        emailTxtField.placeholder = "Email"
        
        // Password
        let passwTxtField = CustomTextField()
        passwTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        passwTxtField.placeholder = "Password"
        passwTxtField.borderStyle = .roundedRect
        passwTxtField.dropShadow()
        
        
        // Horizontal line separators
        let separatorLineOne = UIView()
        separatorLineOne.backgroundColor = .black
        separatorLineOne.constrainHeight(constant: 1)
        
        let separatorLineTwo = UIView()
        separatorLineTwo.backgroundColor = .black
        separatorLineTwo.constrainHeight(constant: 1)
        
        // OR Label
        let orLabel = UILabel()
        orLabel.text = "OR"
        orLabel.textAlignment = .center
        orLabel.font = UIFont.systemFont(ofSize: 14)
        orLabel.backgroundColor = .yellow
        let separtorStackView = UIStackView(arrangedSubviews: [separatorLineOne, orLabel, separatorLineTwo])
        separtorStackView.spacing = 5
        separtorStackView.alignment = .center
        separtorStackView.distribution = .fillEqually
        
        // Facebook Btn
        let faceBookBtn = CustomButton()
        faceBookBtn.setTitle("Login With Facebook", for: .normal)
        faceBookBtn.setImage(#imageLiteral(resourceName: "fb-icon"), for: .normal)
        faceBookBtn.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        faceBookBtn.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        faceBookBtn.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3529411765, blue: 0.5882352941, alpha: 1)
        faceBookBtn.dropShadow()
        
        // Google Btn
        let googleBtn = CustomButton()
        googleBtn.setTitle("Login With Google", for: .normal)
        googleBtn.setImage(#imageLiteral(resourceName: "google-icon"), for: .normal)
        googleBtn.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        googleBtn.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        googleBtn.backgroundColor = .white
        googleBtn.setTitleColor(.darkGray, for: .normal)
        googleBtn.layer.borderWidth = 2
        googleBtn.layer.borderColor = UIColor.darkGray.cgColor
        

        // Adding subViews
        view.addSubview(cardView)
        cardView.addSubview(usernameTxtField)
        cardView.addSubview(emailTxtField)
        cardView.addSubview(passwTxtField)
        cardView.addSubview(separtorStackView)
        cardView.addSubview(faceBookBtn)
        cardView.addSubview(googleBtn)
        
        // ParentView constraints
        if UIScreen.main.bounds.height >= 667 {
            cardView.constrainHeight(constant: 450.adjusted)
            googleBtn.constrainHeight(constant: 40.adjusted)
            faceBookBtn.constrainHeight(constant: 40.adjusted)
            passwTxtField.constrainHeight(constant: 40.adjusted)
            emailTxtField.constrainHeight(constant: 40.adjusted)
            usernameTxtField.constrainHeight(constant: 40.adjusted)


        } else {
            cardView.constrainHeight(constant: 450.adjusted)
            googleBtn.constrainHeight(constant: 40.adjusted)
            faceBookBtn.constrainHeight(constant: 40.adjusted)
            passwTxtField.constrainHeight(constant: 40.adjusted)
            emailTxtField.constrainHeight(constant: 40.adjusted)
            usernameTxtField.constrainHeight(constant: 40.adjusted)
        }
        
        cardView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 30, bottom: 0, right: 30))
        cardView.centerYInSuperview()
     
        usernameTxtField.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        emailTxtField.anchor(top: usernameTxtField.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20))
        
        passwTxtField.anchor(top: emailTxtField.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 15, left: 20, bottom: 0, right: 20))
        
        
        separtorStackView.anchor(top: nil, leading: cardView.leadingAnchor, bottom: faceBookBtn.topAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 30))
        separtorStackView.constrainHeight(constant: 50)
        
        // Facebook constraints
        faceBookBtn.anchor(top: nil, leading: cardView.leadingAnchor, bottom: googleBtn.topAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 10, right: 30))
        
        // Google constraints
        googleBtn.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30, bottom: 15, right: 30))
    }
}

