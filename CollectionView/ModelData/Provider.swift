//
//  Provider.swift
//  Pinterest
//
//  Created by Anastasia Demidova on 11.05.2021.
//

import UIKit.UIImage

struct Provider {
    static func getCategory() -> [Model] {
        guard let image = UIImage(named: "noImage") else { return .init() }
        return [
            Model(name: "Cities", image: UIImage(named: "Сities") ?? image),
            Model(name: "Flowers", image: UIImage(named: "Flowers") ?? image),
            Model(name: "Food", image: UIImage(named: "Food") ?? image),
            Model(name: "Cars", image: UIImage(named: "Cars") ?? image)
        ]
    }
    
    static func loadData(directory name: String) -> [UIImage] {
        let directory = PhotosDataSource(directory: name)
        return directory.loadImages()
    }
}
