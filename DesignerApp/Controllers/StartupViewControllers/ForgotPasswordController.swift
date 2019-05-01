//
//  ForgetPasswordController.swift
//  DesignerApp
//
//  Created by Moe on 30/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordController: UIViewController {
    
    // MARK: - Properties
    
    // Popup View
    let forgotPWView = UIView()
    
    // FPW Label
    let forgotPWLabel = UILabel(text: "Forgot your password? Enter your email below, and the check your inbox.", font: .systemFont(ofSize: 20), numberOfLines: 0)
    
    // Email txtField
    let emailTxtField = CustomTextField()
    
    // Reset Btn
    let resetPWButton = UIButton(type: .system)
   
    // Cancel Btn
    let cancelBtn = UIButton(type: .system)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setupViews()
    }
    
    // MARK: - Firebase ForgotPW method
    @objc func restPWClicked() {
        guard let email = emailTxtField.text, !email.isEmpty  else {
            simpleAlert(title: "Error", msg: "Please enter an email.")
            return
        }
        
        self.dismiss(animated: true) {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    debugPrint("Error sending email: ", error)
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                }
                print("Successfully sent email!")
            }
        }
    }
    
    @objc func cancelBtnClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI Views
extension ForgotPasswordController {
    
    fileprivate func customUIViews() {
        
        forgotPWView.backgroundColor = .white
        forgotPWView.layer.cornerRadius = 8
        forgotPWView.constrainHeight(constant: 200.adjusted)
        
        forgotPWLabel.textAlignment = .center
        forgotPWLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        emailTxtField.placeholder = "Your Email"
        
        resetPWButton.setTitle("Reset", for: .normal)
        resetPWButton.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        resetPWButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        resetPWButton.addTarget(self, action: #selector(restPWClicked), for: .touchUpInside)
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        cancelBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
    }
}

// MARK: - UI Setup
extension ForgotPasswordController {
    
    fileprivate func setupViews() {
        customUIViews()
        let btnStackView = UIStackView(arrangedSubviews: [cancelBtn, resetPWButton])
        btnStackView.distribution = .fillEqually
        btnStackView.alignment = .fill
        btnStackView.spacing = 20
        
        let stackView = VerticalStackView(arrangedSubviews: [
            forgotPWLabel,
            emailTxtField,
            btnStackView
            ], spacing: 20)
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        view.addSubview(forgotPWView)
        forgotPWView.addSubview(stackView)
        
        forgotPWView.centerYInSuperview()
        forgotPWView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        stackView.anchor(top: forgotPWView.topAnchor, leading: forgotPWView.leadingAnchor, bottom: forgotPWView.bottomAnchor, trailing: forgotPWView.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 20, right: 20))
    }
}
