//
//  CustomCollectionViewCell.swift
//  CollectionView
//
//  Created by Anastasia Demidova on 10.03.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var collectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        collectionImage.image = nil
//    }
    
    func configureCell(_ image: UIImage?) {
        collectionImage.image = image
    }
}
