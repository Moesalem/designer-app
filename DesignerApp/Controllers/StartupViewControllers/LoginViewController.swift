//
//  LoginViewController.swift
//  DesignerApp
//
//  Created by Moe on 29/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    // TextFields
    let emailTxtField = CustomTextField()
    let passwTxtField = CustomTextField()
    
    // Sign In Btn
    let loginBtn = UIButton(type: .system)
    
    // Forgot Password Btn
    let forgetPasswordBtn = UIButton(type: .system)
    
    // ActivityIndcator
    let activityIndcator = UIActivityIndicatorView(style: .whiteLarge)
    
    // Dismiss Btn
    let dismissBtn = UIButton(type: .system)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        setupViews()
    }
    
    @objc func signInUser() {
        
        guard let email = emailTxtField.text, !email.isEmpty,
            let password = passwTxtField.text, !password.isEmpty else { return }
        
        activityIndcator.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                debugPrint("Error Logging in user: ", error)
                strongSelf.handleFireAuthError(error: error)
                strongSelf.activityIndcator.stopAnimating()
                return
            }
            
            if let user = user {
                let uid = user.user.uid // user id
                let email = user.user.email // user email
                print("Successfully Logged in", uid, email!)
            }
            self?.present(MainTabBarController(), animated: true, completion: nil)
            strongSelf.activityIndcator.stopAnimating()
        }
    }
    
    @objc func dismissLoginVC () {
        self.dismiss(animated: true, completion: nil)
    }
 
}

// MARK: - UI Views
extension LoginViewController {
  
    fileprivate func customUIViews() {
        
        // Dismiss Btn
        dismissBtn.setTitle("Dismiss", for: .normal)
        dismissBtn.setTitleColor(.darkGray, for: .normal)
        dismissBtn.backgroundColor = .white
        dismissBtn.addTarget(self, action: #selector(dismissLoginVC), for: .touchUpInside)
        
        // Email UI
        emailTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        emailTxtField.placeholder = "Email"
        
        // Password UI
        passwTxtField.backgroundColor = #colorLiteral(red: 1, green: 0.6941176471, blue: 0.6, alpha: 1)
        passwTxtField.placeholder = "Password"
        passwTxtField.borderStyle = .roundedRect
        passwTxtField.dropShadow()
        
        // ForgetPassword UI
        forgetPasswordBtn.setTitle("Forget Password?", for: .normal)
        forgetPasswordBtn.backgroundColor = .darkGray
        forgetPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.adjusted, weight: UIFont.Weight(rawValue: 6.adjusted))
        forgetPasswordBtn.layer.cornerRadius = 8
        forgetPasswordBtn.setTitleColor(.white, for: .normal)
        forgetPasswordBtn.dropShadow()

        // SignIn Btn UI
        loginBtn.setTitle("Sign In", for: .normal)
        loginBtn.backgroundColor = #colorLiteral(red: 0.8218338816, green: 0.2417618034, blue: 0.2666666667, alpha: 1)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.adjusted, weight: UIFont.Weight(rawValue: 6.adjusted))
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.dropShadow()
        loginBtn.addTarget(self, action: #selector(signInUser), for: .touchUpInside)
        
    }
}

//MARK: - UI Layout
extension LoginViewController {
    
    func setupViews() {
        customUIViews()
        
        let stackView = VerticalStackView(arrangedSubviews: [emailTxtField, passwTxtField, forgetPasswordBtn, loginBtn], spacing: 12)
        stackView.distribution = .fillEqually
        
        // UIView Extended
        view.addSubviews(dismissBtn, stackView)
        
        // Layout
        dismissBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        dismissBtn.constrainHeight(constant: 50)
        
        stackView.anchor(top: dismissBtn.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 0, right: 20))
        stackView.constrainHeight(constant: 150)
        
        activityIndcator.centerInSuperview()
    }
}
