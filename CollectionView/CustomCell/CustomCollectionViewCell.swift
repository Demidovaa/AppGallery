//
//  CustomCollectionViewCell.swift
//  CollectionView
//
//  Created by Anastasia Demidova on 10.03.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var collectionImage: UIImageView!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        layer.cornerRadius = 6
        layer.masksToBounds = true
        collectionImage.layer.cornerRadius = 6
        backView.layer.cornerRadius = 6
    }
        
    func configureCell(_ image: UIImage?, _ description: String) {
        collectionImage.image = image
        infoLabel.text = description
    }
}
