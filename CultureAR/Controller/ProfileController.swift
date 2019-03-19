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
    

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    
    
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem?.tintColor = .black
        

        borderView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
        borderView.layer.borderWidth = 4
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        observeUser()
    }
    
    
    func observeUser() {
        let userId = Auth.auth().currentUser!.uid
        
        Database.database().reference().child("Users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            guard let values = snapshot.value as? [String:String] else { return }
            let user = User(id: userId, dictionary: values)
            
            self.profileImage.kf.setImage(with: URL(string: user.image))
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            
        }
        
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let LoginView = LoginController()
            present(LoginView, animated: true, completion: nil)
            
        } catch let err {
            print(err)
        }
        
    }
    
    
}

