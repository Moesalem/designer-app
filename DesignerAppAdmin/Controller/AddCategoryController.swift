//
//  AddCategoryController.swift
//  DesignerAppAdmin
//
//  Created by Moe on 06/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit

class AddCategoryController: UIViewController {
    
    
    let categoryNameTextField: CustomTextField = {
        let txtField = CustomTextField()
        txtField.placeholder = "Enter Category Name"
        txtField.constrainHeight(constant: 50)
        return txtField
    }()
    
    let categoryImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.constrainHeight(constant: 200)
        image.constrainWidth(constant: 200)
        return image
    }()
    
    let imageBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Click to add image", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        return btn
    }()
    
    let addProductBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.setTitle("Add Category", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), for: .normal)
        btn.constrainHeight(constant: 50)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Category"
        view.backgroundColor = .white

        view.addSubview(categoryNameTextField)
        view.addSubview(categoryImageView)
        view.addSubview(imageBtn)
        view.addSubview(addProductBtn)
        
        categoryNameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 10, bottom: 0, right: 10))
        
        categoryImageView.centerInSuperview()
        
        imageBtn.anchor(top: categoryImageView.topAnchor, leading: categoryImageView.leadingAnchor, bottom: categoryImageView.bottomAnchor, trailing: categoryImageView.trailingAnchor)
        
        addProductBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 30, right: 10))
        
    }
    
    
    @objc func imageTapped() {
        imagePickerClicked()
    }
}

extension AddCategoryController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerClicked() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] {
            categoryImageView.image = editedImage as? UIImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] {
            categoryImageView.image = originalImage as? UIImage
        }
        self.imageBtn.setTitle("", for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
