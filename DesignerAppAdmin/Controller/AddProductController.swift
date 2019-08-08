//
//  AddProductController.swift
//  DesignerAppAdmin
//
//  Created by Moe on 07/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import UIKit
import Firebase
class AddProductController: UIViewController {
    
    var selectedCategory: Category!
    var productToEdit: Product?
    
    let productNameLabel: UILabel = {
        let label = UILabel(text: "Product Name", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let productNameTextField: CustomTextField = {
        let txtField = CustomTextField()
        txtField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        txtField.attributedPlaceholder = NSAttributedString(string: "Enter Product Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        txtField.constrainHeight(constant: 50)
        return txtField
    }()
    
    let productPriceTextField: CustomTextField = {
        let txtField = CustomTextField()
        txtField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        txtField.attributedPlaceholder = NSAttributedString(string: "Enter Product Price", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        txtField.constrainHeight(constant: 50)
        txtField.keyboardType = .decimalPad
        return txtField
    }()
    
    let productImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
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
        btn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        btn.constrainHeight(constant: 50)
        btn.addTarget(self, action: #selector(addProductClicked), for: .touchUpInside)
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
        
        print("HII", selectedCategory.id)
        print("LLOOOL", productToEdit?.id ?? "NO NO")
        
        navigationItem.title = "Category"
        view.backgroundColor = .white
        
        view.addSubview(productNameLabel)
        view.addSubview(productNameTextField)
        view.addSubview(productPriceTextField)
        
        view.addSubview(productImageView)
        view.addSubview(imageBtn)
        view.addSubview(addProductBtn)
        view.addSubview(activityIndicator)
        
        productNameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 10, bottom: 0, right: 10))
        
        productNameTextField.anchor(top: productNameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 10, bottom: 0, right: 10))
        
        productPriceTextField.anchor(top: productNameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        productImageView.centerInSuperview()
        
        imageBtn.anchor(top: productImageView.topAnchor, leading: productImageView.leadingAnchor, bottom: productImageView.bottomAnchor, trailing: productImageView.trailingAnchor)
        
        addProductBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 30, right: 10))
        
        activityIndicator.centerInSuperview()

        if let productToEdit = productToEdit {
            productNameTextField.text = productToEdit.name
            productPriceTextField.text = String(productToEdit.price)
            addProductBtn.setTitle("Save Changes", for: .normal)
            if let url = URL(string: productToEdit.imgUrl) {
                productImageView.kf.setImage(with: url)
            }
        }
    }
    
    
    @objc func imageTapped() {
        imagePickerClicked()
    }
    
    @objc func addProductClicked() {
        uploadProduct()
        activityIndicator.startAnimating()
    }
    
    func uploadProduct() {
        
        guard let image = productImageView.image,
            let productName = productNameTextField.text, !productName.isEmpty,
            let productPrice = productPriceTextField.text, !productPrice.isEmpty else {
                self.simpleAlert(title: "Error", msg: "Product Name & Price & Image must not be empty")
                return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let storageRef = Storage.storage().reference().child("/products/\(productName).jpg")
        
        let metaData = StorageMetadata()
        
        metaData.contentType = "jpg"
        
        storageRef.putData(imageData, metadata: metaData) { (metadata, error) in
            if let error = error {
                self.handleError(error: error, errMsg: "Failed to upload!")
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    self.handleError(error: error, errMsg: "Failed to retrieve download url!")
                }
                
                guard let url = url else { return }
                self.writeProductDoc(url: url.absoluteString)
            }
        }
    }
    
    
    func writeProductDoc(url: String) {
        let docRef: DocumentReference!
        
        var product = Product.init(name: productNameTextField.text!, id: "", category: selectedCategory.id, imgUrl: url, price: Double(productPriceTextField.text!)!, timestamp: Timestamp(), isFeatured: true)
        
        
        if let productToEdit = productToEdit {
            docRef = Firestore.firestore().collection("Products").document(productToEdit.id)
            product.id = productToEdit.id
            print(productToEdit.id)
        } else {
            docRef = Firestore.firestore().collection("Products").document()
            product.id = docRef.documentID
        }
      
        let productData = Product.modelToData(product: product)
        
        docRef.setData(productData, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, errMsg: "Failed")
            }
            
            self.activityIndicator.stopAnimating()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func handleError(error: Error, errMsg: String) {
          print("Error", error.localizedDescription)
          self.simpleAlert(title: "Error", msg: errMsg)
      }
}

extension AddProductController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerClicked() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] {
            productImageView.image = editedImage as? UIImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] {
            productImageView.image = originalImage as? UIImage
        }
        self.imageBtn.setTitle("", for: .normal)
        dismiss(animated: true, completion: nil)
    }
}

