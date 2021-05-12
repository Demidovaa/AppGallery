//
//  ViewController.swift
//  CollectionView
//
//  Created by Anastasia Demidova on 10.03.2021.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private var datasource: [Model] = Provider.getCategory()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Category"
        createCell()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        guard let layout = collectionView.collectionViewLayout as? PinterestLayout else { return }
        layout.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigatinBar()
    }
    
    //MARK: - Private Func
    
    private func configureNavigatinBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func createCell() {
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "CustomCollectionViewCell", for: indexPath)
                as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(datasource[indexPath.row].image, datasource[indexPath.row].name)
        return cell
    }
}

extension CategoryViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = datasource[indexPath.row].image
        let hieght = image.size.height
        return hieght / 7 + 40
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
                as? DetailViewController else { return }

        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
