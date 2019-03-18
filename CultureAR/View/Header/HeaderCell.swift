//
//  HeaderCell.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "6")]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "RecommendedCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }

}

extension HeaderCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecommendedCell
        cell.image.image = images[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 270)
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }


    
    
}
