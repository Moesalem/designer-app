//
//  ViewController.swift
//  DesignerApp
//
//  Created by Moe on 27/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Firebase

class StartupViewController: UIViewController {
    
    // ***********************
    // MARK: - UI Properties
    // ***********************
    
    // Main Parent View
    let cardView = UIView()
    
    // TextFields
    let usernameTxtField = CustomTextField()
    let emailTxtField = CustomTextField()
    let passwTxtField = CustomTextField()
    
    // Sign In Btn
    let loginBtn = UIButton(type: .system)
    
    // Sign Up Btn
    let signUpBtn = UIButton(type: .system)
    
    // Horizontal line separators
    let separatorLineOne = UIView()
    let separatorLineTwo = UIView()
    
    // OR Label
    let orLabel = UILabel()
    
    // Horizontal line separators StackView
    let separtorStackView = UIStackView()
    
    // Facebook Btn
    let faceBookBtn = CustomButton()
    
    // Google Btn
    let googleBtn = CustomButton()
    
    // ActivityIndcator
    let activityIndcator = UIActivityIndicatorView(style: .gray)
    
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 0.03137254902, blue: 0.2666666667, alpha: 1))
        setupViews()
    }
    
    @objc func presentLoginVC() {
        self.present(LoginViewController(), animated: true, completion: nil)
    }
}

//MARK: - Signing up new users with different methods
extension StartupViewController {
    
    @objc func signUpNewUser() {
        guard let email = emailTxtField.text, !email.isEmpty,
            let username = usernameTxtField.text, !username.isEmpty,
            let password = passwTxtField.text, !password.isEmpty else {
                simpleAlert(title: "Error", msg: "Please fill up all inputs.")
                return
        }
        
        activityIndcator.startAnimating()
        
        guard let authUser = Auth.auth().currentUser else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        authUser.link(with: credential) { (result, error) in
            if let error = error {
                debugPrint("Error Linkin user: ", error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                self.activityIndcator.stopAnimating()
                return
            }
            
            print("Succefuly registered new user.")
            self.activityIndcator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func signUpWithFB() {
        // TODO: TODO: Signing in user with Facebook
    }
    
    @objc func signUpWithGoogle() {
        // TODO: TODO: Signing in user with google
    }
}

//MARK: - UI Views
extension StartupViewController {

    fileprivate func customUIViews() {
        
        // Main Parent View UI
        cardView.backgroundColor = .clear
        cardView.layer.cornerRadius = 10
        cardView.dropShadow()
        
        // Username UI
        usernameTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        usernameTxtField.placeholder = "Username"
        
        // Email UI
        emailTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        emailTxtField.placeholder = "Email"
        
        // Password UI
        passwTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        passwTxtField.placeholder = "Password"
        passwTxtField.borderStyle = .roundedRect
        passwTxtField.dropShadow()
        
        // SignIn Btn UI
        loginBtn.setTitle("Sign In", for: .normal)
        loginBtn.backgroundColor = #colorLiteral(red: 0.8218338816, green: 0.2417618034, blue: 0.2666666667, alpha: 1)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.adjusted, weight: UIFont.Weight(rawValue: 6.adjusted))
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.dropShadow()
        loginBtn.addTarget(self, action: #selector(presentLoginVC), for: .touchUpInside)
        
        // SignUp Btn UI
        signUpBtn.setTitle("Sign Up", for: .normal)
        signUpBtn.backgroundColor = #colorLiteral(red: 0.8218338816, green: 0.03137254902, blue: 0.2666666667, alpha: 1)
        signUpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.adjusted, weight: UIFont.Weight(rawValue: 6.adjusted))
        signUpBtn.layer.cornerRadius = 8
        signUpBtn.setTitleColor(.white, for: .normal)
        signUpBtn.dropShadow()
        signUpBtn.addTarget(self, action: #selector(signUpNewUser), for: .touchUpInside)
        
        // Horizontal line separators UI
        separatorLineOne.backgroundColor = .black
        separatorLineOne.constrainHeight(constant: 1)
        
        separatorLineTwo.backgroundColor = .black
        separatorLineTwo.constrainHeight(constant: 1)
        
        // OR Label UI
        orLabel.text = "OR"
        orLabel.textAlignment = .center
        orLabel.font = UIFont.systemFont(ofSize: 14)
        
        // Horizontal line separators StackView UI
        separtorStackView.addArrangedSubviews(separatorLineOne, orLabel, separatorLineTwo)
        separtorStackView.spacing = 1
        separtorStackView.alignment = .center
        separtorStackView.distribution = .fillEqually
        
        // Facebook Btn UI
        faceBookBtn.setTitle("Login With Facebook", for: .normal)
        faceBookBtn.setImage(#imageLiteral(resourceName: "fb-icon"), for: .normal)
        faceBookBtn.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        faceBookBtn.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        faceBookBtn.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3529411765, blue: 0.5882352941, alpha: 1)
        faceBookBtn.dropShadow()
        faceBookBtn.addTarget(self, action: #selector(signUpWithFB), for: .touchUpInside)

        
        // Google Btn UI
        googleBtn.setTitle("Login With Google", for: .normal)
        googleBtn.setImage(#imageLiteral(resourceName: "google-icon"), for: .normal)
        googleBtn.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 20)
        googleBtn.titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        googleBtn.backgroundColor = .white
        googleBtn.setTitleColor(.darkGray, for: .normal)
        googleBtn.layer.borderWidth = 2
        googleBtn.layer.borderColor = UIColor.darkGray.cgColor
        googleBtn.addTarget(self, action: #selector(signUpWithGoogle), for: .touchUpInside)

    }
}

//MARK: - UI Layout
extension StartupViewController {
    
    fileprivate func setupViews() {
        customUIViews()
        // Adding subViews
        view.addSubview(cardView)
        view.addSubview(activityIndcator)
        
        // VARIDIC ARGS
        cardView.addSubviews(usernameTxtField, emailTxtField, passwTxtField, loginBtn,signUpBtn, separtorStackView, faceBookBtn, googleBtn)
        
        // UIViews Height
        cardView.constrainHeight(constant: 450.adjusted)
        usernameTxtField.constrainHeight(constant: 40.adjusted)
        emailTxtField.constrainHeight(constant: 40.adjusted)
        passwTxtField.constrainHeight(constant: 40.adjusted)
        loginBtn.constrainHeight(constant: 40.adjusted)
        signUpBtn.constrainHeight(constant: 40.adjusted)
        googleBtn.constrainHeight(constant: 40.adjusted)
        faceBookBtn.constrainHeight(constant: 40.adjusted)
        
        activityIndcator.centerInSuperview()
        
        // ParentView constraints
        cardView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 30.adjusted, bottom: 0, right: 30.adjusted))
        cardView.centerYInSuperview()
        
        // usernameTxt constraints
        usernameTxtField.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 20.adjusted, left: 30.adjusted, bottom: 0, right: 30.adjusted))
        
        // emailTxt constraints
        emailTxtField.anchor(top: usernameTxtField.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 15.adjusted, left: 30.adjusted, bottom: 0, right: 30.adjusted))
        
        // passwTxt constraints
        passwTxtField.anchor(top: emailTxtField.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 15.adjusted, left: 30.adjusted, bottom: 0, right: 30.adjusted))
        
        // signIn constraints
        loginBtn.anchor(top: nil, leading: cardView.leadingAnchor, bottom: signUpBtn.topAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30.adjusted, bottom: 5.adjusted, right: 30.adjusted))
        
        // signUp constraints
        signUpBtn.anchor(top: nil, leading: cardView.leadingAnchor, bottom: separtorStackView.topAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30.adjusted, bottom: 0
            , right: 30.adjusted))
        
        // separtorStackView constraints
        separtorStackView.anchor(top: nil, leading: cardView.leadingAnchor, bottom: faceBookBtn.topAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30.adjusted, bottom: 0, right: 30.adjusted))
        separtorStackView.constrainHeight(constant: 50.adjusted)
        
        // Facebook constraints
        faceBookBtn.anchor(top: nil, leading: cardView.leadingAnchor, bottom: googleBtn.topAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30.adjusted, bottom: 10.adjusted, right: 30.adjusted))
        
        // Google constraints
        googleBtn.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 30.adjusted, bottom: 15.adjusted, right: 30.adjusted))
    }
}

