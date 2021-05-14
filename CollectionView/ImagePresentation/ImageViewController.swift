//
//  ImageViewController.swift
//  Pinterest
//
//  Created by Anastasia Demidova on 15.03.2021.
//

import UIKit

class ImageViewController: UIViewController {
    
    //MARK: - Properties
    
    var imageScrollView: ImageScrollView!
    var image = UIImage()
    var photoIndex: Int!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView = ImageScrollView(frame: view.bounds)
                
        view.addSubview(imageScrollView)
        setupImageScrollView()
        
        self.imageScrollView.set(image: image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    //MARK: - Private func
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
