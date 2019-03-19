//
//  PostEventController.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 18/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

class PostEventController: UIViewController {
    
    //MARK: - PROGRAMMATIC VIEW-SETUP
    var selectedImage: UIImage? {
        didSet {
            selectedImageView.image = selectedImage
        }
    }
    
    private let captionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let selectedImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let captionTextView: UITextView = {
        let text = UITextView()
        text.textColor = .black
        text.backgroundColor = .clear
        return text
    }()
    
    private let firstSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9364490799, green: 0.9364490799, blue: 0.9364490799, alpha: 1)
        return view
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Location"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()
    
    private let locationTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.placeholder = "Pretoria, South Africa"
        tf.font = UIFont.systemFont(ofSize: 13)
        return tf
    }()
    
    private let tfBorder: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9364490799, green: 0.9364490799, blue: 0.9364490799, alpha: 1)
        return view
    }()
    
    
    //MARK: - CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 241, green: 241, blue: 241)
        view.backgroundColor = .white
        setupNavigationController()
        setupCaptionView()
    }
    
    
    fileprivate func setupNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
    }
    
    
    @objc func handleShare() {
        guard let image = selectedImage else {return}
//        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else {return}
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else {return}
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        let filename = NSUUID().uuidString
        
        let ref = Storage.storage().reference().child("posts").child("images").child(filename)
        ref.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Failed to upload post image to storage:", err)
                return
            }
            print("Sucessfully uploaded image to storage")
            ref.downloadURL(completion: { (url, err) in
                if let err = err {
                    print("Failed to retrieve post image url", err)
                    return
                }
                guard let url = url?.absoluteString else {return}
                self.savePostToDatabase(withURL: url)
            })
        }
    }
    
    fileprivate func savePostToDatabase(withURL url:String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let caption = self.captionTextView.text else {return}
        let location = self.locationTextField.text ?? ""
        guard let postImage = selectedImage else {return}
        
        let ref = Database.database().reference().child("posts").child(uid).childByAutoId()
        let values = ["post_image_url": url,
                      "caption": caption,
                      "location": location,
                      "image_height": postImage.size.height,
                      "creation_date": Date().timeIntervalSince1970] as [String:Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload post to database", err)
                return
            }
            print("Sucessfully uploaded image post to database")
            self.dismiss(animated: true, completion: nil)
            
            let name = NSNotification.Name(rawValue: "UpdatePost")
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    
    
    fileprivate func setupCaptionView() {
        view.addSubview(captionView)
        captionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 180))
        captionView.addSubview(selectedImageView)
        selectedImageView.anchor(top: captionView.topAnchor, leading: captionView.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 80, height: 80))
        captionView.addSubview(captionTextView)
        captionTextView.anchor(top: captionView.topAnchor, leading: selectedImageView.leadingAnchor, bottom: nil, trailing: captionView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: CGSize(width: 0, height: 80))
        captionView.addSubview(firstSeperatorView)
        firstSeperatorView.anchor(top: captionTextView.bottomAnchor, leading: captionView.leadingAnchor
            , bottom: nil, trailing: captionView.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: CGSize(width: 0, height: 1))
        captionView.addSubview(locationLabel)
        locationLabel.anchor(top: firstSeperatorView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,  padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        captionView.addSubview(tfBorder)
        tfBorder.anchor(top: nil, leading: view.leadingAnchor, bottom: captionView.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 8, right: 16), size: CGSize(width: 0, height: 1.5))
        captionView.addSubview(locationTextField)
        locationTextField.anchor(top: nil, leading: view.leadingAnchor, bottom: tfBorder.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 20))
    }
}

