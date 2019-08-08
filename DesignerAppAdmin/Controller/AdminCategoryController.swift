//
//  AdminCategoryController.swift
//  DesignerAppAdmin
//
//  Created by Moe on 06/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseFirestore
import Firebase

class AdminCategoryController: CategoryController {
    
    // MARK: - Properties
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
        collectionView.backgroundColor = .white
        
        navigationItem.title = "Admin"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goAddCategory))
        
        
    }
    
    @objc func goAddCategory(){
        self.navigationController?.pushViewController(AddCategoryController(), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let adminProductController = AdminProductController()
        
        adminProductController.category = categories[indexPath.item]
        adminProductController.navigationItem.title = categories[indexPath.item].name
         self.navigationController?.pushViewController(adminProductController, animated: true)
    }
    
}
