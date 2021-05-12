//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Anastasia Demidova on 11.03.2021.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCell()
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
        setGradientBackground()
    }
    
    //MARK: - Private func
    
    private func configureNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .systemYellow
        navigationBar?.tintColor = .black
        navigationBar?.isHidden = false
    }
    
    private func createCell() {
        let nib = UINib(nibName: "DetailCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "DetailCollectionViewCell")
    }
    
    private func setGradientBackground() {
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(image: nil)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let imageVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController")
                as? ImageViewController else { return }
        imageVC.image = UIImage(named: "noImage")! // needs to be replaced!
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}
