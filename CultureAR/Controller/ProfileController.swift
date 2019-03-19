//
//  ProfileController.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 19/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileController: UIViewController {
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    
    let logoutButton2: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = "Logout"
        return btn
    }()
    
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController!.navigationItem.rightBarButtonItem = logoutButton2
        
        profileImage.anchor(view: view, top: view.safeAreaLayoutGuide.topAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0), size: CGSize(width: 50, height: 50))
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameLabel.anchor(view: view, top: profileImage.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        emailLabel.anchor(view: view, top: nameLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        logoutButton.anchor(view: view, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 16, right: 50))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        observeUser()
    }
    
    
    func observeUser() {
        let userId = Auth.auth().currentUser!.uid
        
        Database.database().reference().child("Users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            guard let values = snapshot.value as? [String:String] else { return }
            let event = User(id: userId, dictionary: values)
            self.profileImage.kf.setImage(with: URL(string: event.image))
            self.nameLabel.text = event.name
            self.emailLabel.text = event.email
            
        }
        
    }
    
    @objc func logout() {
        do {
            try Auth.auth().signOut()
            let LoginView = LoginController()
            present(LoginView, animated: true, completion: nil)
            
        } catch let err {
            print(err)
        }
        
    }
    
    
}

