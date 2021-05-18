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
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigatinBar()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection != nil else { return }
        if let customLayout = collectionView.collectionViewLayout as? PinterestLayout {
            customLayout.currentTrait = traitCollection
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }) { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
    
    //MARK: - Private Func
    
    private func configureNavigatinBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionView() {
        collectionView.register(cellType: CustomCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        guard let layout = collectionView.collectionViewLayout as? PinterestLayout else { return }
        layout.delegate = self
        layout.currentTrait = traitCollection
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CustomCollectionViewCell.self,
                                                      for: indexPath)
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
        guard let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
                as? DetailViewController else { return }
        let name = datasource[indexPath.row].name
        let photo = Provider.loadData(directory: name)
        controller.images = photo
        controller.category = name
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
