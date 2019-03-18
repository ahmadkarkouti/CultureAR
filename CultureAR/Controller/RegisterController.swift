//
//  RegisterController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class RegisterController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - References
    var ref: DatabaseReference!
    var refCurrent: DatabaseReference!
    var refAllergy: DatabaseReference!
    var uid = ""
    
    // MARK: - Skeleton
    var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.contentSize.height = 2000
        sv.isScrollEnabled = true
        sv.backgroundColor = .clear
        return sv
    }()
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "user-silhouette-gray")
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let chooseImage : UIButton = {
        let cv = UIButton()
        cv.backgroundColor = .clear
        cv.addTarget(self, action: #selector(handleSelectProfileImageView), for: .touchUpInside)
        return cv
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let heightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Height"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Weight"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let CalorieTargerTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Maximum Calorie Target"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let RegisterButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.isEnabled = true
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        return button
    }()
    
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: "Login now", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue:237/255, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        
        scrollView.anchor(view: view, top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        imageView.anchor(view: scrollView, top: scrollView.topAnchor, padding: UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0), size: CGSize(width: 80, height: 80))
        
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        chooseImage.anchor(view: scrollView, top: scrollView.topAnchor, padding: UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0), size: CGSize(width: 80, height: 80))
        chooseImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,heightTextField,weightTextField,CalorieTargerTextField,RegisterButton])
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.axis = .vertical
        
        stackView.anchor(view: scrollView, top: chooseImage.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 64, left: 32, bottom: 0, right: 32), size: CGSize(width: 0, height: 370))
        
        signupButton.anchor(view: scrollView, leading: scrollView.leadingAnchor, bottom: scrollView.safeAreaLayoutGuide.bottomAnchor, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0), size: CGSize(width: 0, height: 0))
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        //creating flexible space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // creating button
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        
        // adding space and button to toolbar
        keyboardToolbar.setItems([flexibleSpace,addButton], animated: false)
        nameTextField.inputAccessoryView = keyboardToolbar
        emailTextField.inputAccessoryView = keyboardToolbar
        passwordTextField.inputAccessoryView = keyboardToolbar
        heightTextField.inputAccessoryView = keyboardToolbar
        weightTextField.inputAccessoryView = keyboardToolbar
        CalorieTargerTextField.inputAccessoryView = keyboardToolbar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    // MARK: - Functions
    @objc func login() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func register() {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if error == nil {
                guard let user = authResult?.user else { return }
                
                let storageRef = Storage.storage().reference().child("users").child("\(user.uid).png")
                if let uploadData = self.imageView.image!.pngData() {
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            return
                        }
                        
                        storageRef.downloadURL(completion: { (url, err) in
                            if let err = err {
                                return
                            }
                            
                            guard let profileImageUrl = url?.absoluteString else {return}
                            
                            self.uid = user.uid
                            self.ref = Database.database().reference().child("Users").child(self.uid)
                            self.ref.setValue(["Name": self.nameTextField.text!, "Email": self.emailTextField.text!, "Password": self.passwordTextField.text!,"Image": profileImageUrl])
                        })
                        
                        
                        
                    })
                }
                
                
                
                print("You have successfully registered!!")
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
}

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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



