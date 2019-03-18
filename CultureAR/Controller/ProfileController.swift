//
//  ProfileController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileController: UIViewController {
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        logoutButton.anchor(view: view, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 16, right: 50))
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
