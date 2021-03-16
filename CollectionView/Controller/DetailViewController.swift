//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Anastasia Demidova on 11.03.2021.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var textView: UITextView!
        
    var imageName = ""
    var image = UIImage()
    let doc = Document()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView(image)
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
    
    private func configureTextView(_ image: UIImage) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 0, y: 10, width: 200, height: 240)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        textView.textContainer.exclusionPaths = [UIBezierPath(rect: imageView.frame)]
        textView.addSubview(imageView)
        
        textView.backgroundColor = .clear
        textView.text = doc.description["\(imageName)"]
        
        textView.isEditable = false
        textView.isSelectable = false
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
    
    @objc
    private func tapHandler() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let imageVC = storyboard.instantiateViewController(withIdentifier: "ImageViewController")
                as? ImageViewController else { return }
        imageVC.image = UIImage(named: imageName)!
        self.navigationController?.pushViewController(imageVC, animated: true)
    }
}
