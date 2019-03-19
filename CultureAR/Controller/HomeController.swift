//
//  HomeController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Kingfisher

class HomeController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: PostGridLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    var ref: DatabaseReference!
    var events: [Event] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = PostGridLayout()
        if let layout = collectionView.collectionViewLayout as? PostGridLayout {
            layout.delegate = self
        }
        collectionView.contentInset.bottom = 410
        view.backgroundColor = .white
        ref = Database.database().reference()
        
        setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        observe()
        events.removeAll()
        if Auth.auth().currentUser != nil {
//            print("UserId: \(Auth.auth().currentUser?.uid ?? "User Not Found!")")
//            let LoginView = CaptureViewController()
//            present(LoginView, animated: true, completion: nil)
        } else {
            let LoginView = LoginController()
            present(LoginView, animated: true, completion: nil)
        }
    }
    
    func observe() {
        
        ref.child("Events").observe(.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            print("=======================================================")
            print(value)
            value?.forEach({ (id, dOd) in
                let event = Event(id: id as! String, dictionary: dOd as! [String : Any])
                print(event)
                self.events.append(event)
            })
            self.collectionView.reloadData()
        }
        
//        ref.child("Events").observeSingleEvent(of: .child) { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//            print("=======================================================")
//            print(value)
//            value?.forEach({ (id, dOd) in
//                print(dOd)
//                guard let dictionary = dOd as? NSDictionary else {return}
//                dictionary.forEach({ (postId, values) in
//                    let event = Event(id: postId as! String, dictionary: values as! [String : String])
//                    print(event)
//                    self.events.append(event)
//                })
//            })
//            self.collectionView.reloadData()
//        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        collectionView.anchor(view: view, top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor ,padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EventCell
        
        let url = URL(string: events[indexPath.row].eventImage)
        cell.imageView.kf.setImage(with: url)
        cell.nameLabel.text = events[indexPath.row].eventName
        cell.descriptionLabel.text = events[indexPath.row].eventDescription
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 410
        )
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderCell
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventController = EventController()
        eventController.headerImage.kf.setImage(with: URL(string: events[indexPath.row].eventImage))
        eventController.passedTitle = events[indexPath.row].eventName
        eventController.passedDescription = events[indexPath.row].eventDescription
        navigationController?.pushViewController(eventController, animated: true)
    }

}

extension HomeController: HeaderCellDelegate {
    func didPressPost() {
        present(PostController(), animated: true)
    }
}


extension HomeController: PostGridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> Float {
        
        let height  = events[indexPath.item].imageHeight
        if height < 850 {
            return 260
        } else {
            return Float((height / 6) + 100)
        }
        
    }
    
}
