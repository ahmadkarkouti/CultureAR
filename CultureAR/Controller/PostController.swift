//
//  PostController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class PostController: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    
    var eventTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Event Name"
        return tf
    }()
    
    var descriptionTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Event Description"
        return tf
    }()
    
    var postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(postEvent), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "9")
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectEventImageView)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let chooseImage : UIButton = {
        let cv = UIButton()
        cv.backgroundColor = .clear
        cv.addTarget(self, action: #selector(handleSelectEventImageView), for: .touchUpInside)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        eventTextField.anchor(view: view, top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 50))
        
        descriptionTextField.anchor(view: view, top: eventTextField.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 50))
        
        postButton.anchor(view: view, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 16, right: 50))
        
        imageView.anchor(view: view, top: descriptionTextField.bottomAnchor, leading: view.leadingAnchor, bottom: postButton.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        chooseImage.anchor(view: view, top: descriptionTextField.bottomAnchor, leading: view.leadingAnchor, bottom: postButton.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        eventTextField.delegate = self
        eventTextField.inputAccessoryView = toolBar
        
        descriptionTextField.delegate = self
        descriptionTextField.inputAccessoryView = toolBar
    }
    
    
    
    @objc func postEvent() {
        let user = Auth.auth().currentUser!
        let key = Database.database().reference().childByAutoId().key
        self.ref = Database.database().reference().child("Events").child(user.uid)
        
//        self.ref.setValue(["Name": self.eventTextField.text!, "Description": self.descriptionTextField.text!, "Image": profileImageUrl])
        
        let storageRef = Storage.storage().reference().child("Events").child("\(key).png")
        if let uploadData = self.imageView.image!.pngData() {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                
                storageRef.downloadURL(completion: { (url, err) in
                    if err != nil {
                        return
                    }
                    
                    guard let profileImageUrl = url?.absoluteString else {return}
                
                    self.ref = Database.database().reference().child("Events").child(user.uid).childByAutoId()
                    self.ref.setValue(["Name": self.eventTextField.text!, "Description": self.descriptionTextField.text!, "Image": profileImageUrl])
                })
                
                
                
            })
        }
        
        
        
        print("You have successfully registered!!")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func donePressed(){
        view.endEditing(true)
    }
    
    @objc func handleSelectEventImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
}

extension PostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            imageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
