//
//  ModelPicker.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 19/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

class ModelPicker: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ModelCell", bundle: nil), forCellWithReuseIdentifier: "ModelCell")

        // Do any additional setup after loading the view.
    }


}

extension ModelPicker: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModelCell", for: indexPath) as! ModelCell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 190)
    }
    
    
}
