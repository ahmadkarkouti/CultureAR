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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    var ref: DatabaseReference!
    
    var experience = ["Augmented Reality", "Personalised Interests", "Sound", "Dark Mode"]
    var alerts = ["Push Notifications", "Email Notifications"]
    var data = ["Interests", "Exhibition History", "Personal Information"]
    var settings = ["Help", "Terms of Service", "Get CultureAR Pro"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        
        borderView.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
        borderView.layer.borderWidth = 4
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileSettingsCell", bundle: nil), forCellReuseIdentifier: "Cell")
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

extension ProfileController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        case 2:
            return 3
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProfileSettingsCell
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = experience[indexPath.row]
        case 1:
            cell.titleLabel.text = alerts[indexPath.row]
        case 2:
            cell.titleLabel.text = data[indexPath.row]
        default:
            cell.titleLabel.text = settings[indexPath.row]
        }
        return cell
    }
    
    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        return vw
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "User Experience"
        case 1:
            return "Alerts"
        case 2:
            return "Data"
        default:
            return " "
        }
    }
}
