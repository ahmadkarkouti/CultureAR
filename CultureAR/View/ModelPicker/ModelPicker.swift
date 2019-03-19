//
//  ModelPicker.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 19/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

protocol ModelPickerDelegate {
    func updateModel(model: ARModel)
}

class ModelPicker: UIViewController {

    let arModels = StaticAPI.shared.arModels
    var delegate: ModelPickerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ModelCell", bundle: nil), forCellWithReuseIdentifier: "ModelCell")
    }

    
    @IBAction func dismissPicker(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension ModelPicker: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ModelCell", for: indexPath) as! ModelCell
        cell.model = arModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.updateModel(model: arModels[indexPath.item])
        dismiss(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 190)
    }
    
    
}
