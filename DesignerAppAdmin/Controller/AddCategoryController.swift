//
//  AddCategoryController.swift
//  DesignerAppAdmin
//
//  Created by Moe on 06/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class AddCategoryController: UIViewController {
    
    var categoryToEdit: Category?
    
    let enterCategoryLabel: UILabel = {
        let label = UILabel(text: "Category Name", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let categoryNameTextField: CustomTextField = {
        var txtField = CustomTextField()
        txtField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        //        txtField.placeholder = "Enter Category Name"
        txtField.layer.borderColor = UIColor.gray.cgColor
        txtField.attributedPlaceholder = NSAttributedString(string: "Enter Category Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        txtField.constrainHeight(constant: 50)
        return txtField
    }()
    
    let categoryImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
    
    let addCategoryBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.setTitle("Add Category", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        btn.constrainHeight(constant: 50)
        btn.addTarget(self, action: #selector(addCategoryClicked), for: .touchUpInside)
        return btn
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activiyIndicator  = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activiyIndicator.hidesWhenStopped = true
        activiyIndicator.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        activiyIndicator.constrainHeight(constant: 100)
        activiyIndicator.constrainWidth(constant: 100)
        activiyIndicator.layer.cornerRadius = 8
        return activiyIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Category"
        view.backgroundColor = .white
        
        view.addSubview(enterCategoryLabel)
        view.addSubview(categoryNameTextField)
        view.addSubview(categoryImageView)
        view.addSubview(imageBtn)
        view.addSubview(addCategoryBtn)
        view.addSubview(activityIndicator)
        
        enterCategoryLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        
        categoryNameTextField.anchor(top:  enterCategoryLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 10, bottom: 0, right: 10))
        
        categoryImageView.centerInSuperview()
        
        imageBtn.anchor(top: categoryImageView.topAnchor, leading: categoryImageView.leadingAnchor, bottom: categoryImageView.bottomAnchor, trailing: categoryImageView.trailingAnchor)
        
        addCategoryBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 30, right: 10))
        
        activityIndicator.centerInSuperview()
        editCategory()
    }
    
    // if categoryToEdit != nil
    func editCategory() {
        
        if let category = categoryToEdit {
            categoryNameTextField.text = category.name
            addCategoryBtn.setTitle("Edit Category", for: .normal)
            if let url = URL(string: category.imgUrl) {
                categoryImageView.contentMode = .scaleAspectFill
                categoryImageView.kf.setImage(with: url)
            }
        }
    }
    
    @objc func imageTapped() {
        imagePickerClicked()
    }
    
    @objc func addCategoryClicked() {
        uploadCategory()
        activityIndicator.startAnimating()
    }
    
    func uploadCategory() {
        
        guard let image = categoryImageView.image,
            let categoryName = categoryNameTextField.text, !categoryName.isEmpty else {
                self.simpleAlert(title: "Error", msg: "Categoy Name & Image must not be empty")
                return
        }
        
        let storageRef = Storage.storage().reference().child("/catagoryImages/\(categoryName).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let metaData = StorageMetadata()
        
        metaData.contentType = "jpg"
        
        storageRef.putData(imageData, metadata: metaData) { (metadata, error) in
            
            if let error = error {
                self.handleError(error: error, errMsg: "Something went wrong with uploading!")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    self.handleError(error: error, errMsg: "Unable to get image url!")
                    return
                }
                guard let url = url else { return }
                self.writeDocument(url: url.absoluteString)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func writeDocument(url: String) {
        let docRef: DocumentReference!
        
        var category = Category(name: categoryNameTextField.text!, id: "", imgUrl: url, timestamp: Timestamp())
        
        if let categoryToEdit = categoryToEdit {
            docRef = Firestore.firestore().collection("categories").document(categoryToEdit.id)
            category.id = categoryToEdit.id
        } else {
            docRef = Firestore.firestore().collection("categories").document()
            category.id = docRef.documentID
        }
        let categoryData = Category.modelToData(category: category)
        
        docRef.setData(categoryData, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, errMsg: "Failed to upload new category!")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleError(error: Error, errMsg: String) {
        print("Error", error.localizedDescription)
        self.simpleAlert(title: "Error", msg: errMsg)
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
