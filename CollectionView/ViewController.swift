//
//  ViewController.swift
//  CollectionView
//
//  Created by Anastasia Demidova on 10.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private var imageSet = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCell()

        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        guard let layout = collectionView.collectionViewLayout as? PinterestLayout else { return }
        layout.delegate = self
    }
    
    //MARK: - Private Func
    
    private func createCell() {
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
}

extension ViewController: UICollectionViewDataSource, PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "\(imageSet[indexPath.row])")
        guard let hieght = image?.size.height else { return 0.0 }
        return hieght / 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CustomCollectionViewCell", for: indexPath)
                as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(UIImage(named: "\(imageSet[indexPath.row])"))
        return cell
    }
}
