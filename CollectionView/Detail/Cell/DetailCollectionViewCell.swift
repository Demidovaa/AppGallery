//
//  DetailCollectionViewCell.swift
//  Pinterest
//
//  Created by Anastasia Demidova on 11.05.2021.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var detailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        detailImage.backgroundColor = .orange
        detailImage.layer.cornerRadius = 6
    }
    
    func configureCell(image: UIImage?) {
        guard let image = image else { return detailImage.image = UIImage(named: "noImage") }
        detailImage.image =  image
    }
}
