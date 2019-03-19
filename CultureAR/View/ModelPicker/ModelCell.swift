//
//  ModelCell.swift
//  CultureAR
//
//  Created by Franck-Stephane Ndame Mpouli on 19/03/2019.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

class ModelCell: UICollectionViewCell {
    
    var model: ARModel? {
        didSet {
            guard let model = model else {return}
            modelImageView.image = model.image
            modelNameLabel.text = model.name
        }
    }

    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var modelNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
