//
//  File.swift
//  DesignerApp
//
//  Created by Moe on 29/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: MainListController {
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    fileprivate let leftBarBtn = UIBarButtonItem()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        anonymousUserSignIn()
        
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.navigationItem.leftBarButtonItem = leftBarBtn
        leftBarBtn.action = #selector(signInOutBtn)
        leftBarBtn.target = self
    }
    
    //MARK:- viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser, !user.isAnonymous {
            leftBarBtn.title = "Logout"
        } else {
            leftBarBtn.title = "Login"
        }
    }
}


// MARK: - DataSource & Delegates

extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .purple
        return cell
    }
}

// MARK: - Delegate Flow Layout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 44)
    }
}

// MARK: - Firebase Authentication Proccess
extension HomeViewController {
    
    fileprivate func anonymousUserSignIn() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (res, error) in
                if let error = error {
                    debugPrint("Error Signing in as anonymous", error.localizedDescription)
                }
                print("success")
            }
        }
    }
    
    @objc func signInOutBtn() {
        
        guard let user = Auth.auth().currentUser else { return }
        
        if user.isAnonymous {
            present(StartupViewController(), animated: true, completion: nil)
        } else {
            
            do {
                try Auth.auth().signOut()
                print("Logout Successfully")
                anonymousUserSignIn()
            } catch {
                debugPrint("Error Signing out user: ", error.localizedDescription)
            }
        }
    }
}
