//
//  File.swift
//  DesignerApp
//
//  Created by Moe on 29/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    fileprivate let leftBarBtn = UIBarButtonItem()
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.navigationItem.leftBarButtonItem = leftBarBtn
        leftBarBtn.action = #selector(leftBarBtnClicked)
        leftBarBtn.target = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = Auth.auth().currentUser {
            leftBarBtn.title = "Logout"
        } else {
            leftBarBtn.title = "Login"
        }
    }
    
    @objc func leftBarBtnClicked() {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
                self.present(LoginViewController(), animated: true, completion: nil)
            } catch {
                debugPrint(error.localizedDescription)
            }
        } else {
            self.present(LoginViewController(), animated: true, completion: nil)
        }
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - DataSource & Delegates

extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - Delegate Flow Layout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 44)
    }
}
