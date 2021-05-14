//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Anastasia Demidova on 11.03.2021.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var images: [UIImage] = []
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        infoLabel.isHidden = !images.isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
        setGradientBackground()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setGradientBackground()
    }
    
    //MARK: - Private func
    
    private func configureNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .systemYellow
        navigationBar?.tintColor = .black
        navigationBar?.isHidden = false
    }
    
    private func configureCollectionView() {
        collectionView.register(cellType: DetailCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setGradientBackground() {
        if let layer = self.view.layer.sublayers?.first, layer is CAGradientLayer {
            layer.removeFromSuperlayer()
        }
        let colorTop = UIColor.systemYellow.cgColor
        let colorBottom = UIColor.white.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
    
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: DetailCollectionViewCell.self,
                                                      for: indexPath)
        cell.configureCell(image: images[indexPath.row])
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let page = storyboard.instantiateViewController(withIdentifier: "PageViewController")
                as? PageViewController else { return }
        page.photos = images
        page.currentIndex = indexPath.row
        self.navigationController?.pushViewController(page, animated: true)
    }
}
