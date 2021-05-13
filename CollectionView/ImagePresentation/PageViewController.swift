//
//  PageViewController.swift
//  Pinterest
//
//  Created by Anastasia Demidova on 13.05.2021.
//

import UIKit

class PageViewController: UIPageViewController {
    
    //MARK: - Properties
    
    var photos: [UIImage] = []
    var currentIndex: Int?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Private func
    
    private func configureView() {
        if let viewController = presentController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .forward, animated: true)
        }
        dataSource = self
    }
    
    private func presentController(_ index: Int) -> ImageViewController? {
        guard let storyboard = storyboard,
              let page = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else { return nil }
        page.photoIndex = index
        page.image = photos[index]
        return page
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? ImageViewController,
              let index = controller.photoIndex,
              index > 0 else { return nil }
        return presentController(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? ImageViewController,
              let index = controller.photoIndex,
              index + 1 < photos.count else { return nil }
        return presentController(index + 1)
    }
}
