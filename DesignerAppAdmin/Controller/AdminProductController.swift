//
//  AdminProductController.swift
//  DesignerAppAdmin
//
//  Created by Moe on 06/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher


class AdminProductController: DesignsListController {
    
    // MARK: - Properties
    
    var selectedProduct: Product?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(DesignCell.self, forCellWithReuseIdentifier: desingCellId)

        let addProductBtn = UIBarButtonItem(title: "Add Product", style: .plain, target: self, action: #selector(addProductBtnClicked))
        
        let editCategoryBtn = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(editCategoryBtnClicked))
        navigationItem.rightBarButtonItems = [addProductBtn, editCategoryBtn]

    }
    
    @objc func addProductBtnClicked() {
        let addProductController = AddProductController()
        addProductController.selectedCategory = category
        addProductController.productToEdit = selectedProduct
        self.navigationController?.pushViewController(addProductController, animated: true)
    }

    @objc func editCategoryBtnClicked() {
        let addCategoryController = AddCategoryController()
        addCategoryController.categoryToEdit = category
        self.navigationController?.pushViewController(addCategoryController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let addProductController = AddProductController()
        selectedProduct = products[indexPath.item]
        addProductController.productToEdit = selectedProduct
        addProductController.selectedCategory = category
        self.navigationController?.pushViewController(addProductController, animated: true)
    }
}
