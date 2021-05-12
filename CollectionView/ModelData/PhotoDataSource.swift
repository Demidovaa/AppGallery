//
//  PhotoDataSource.swift
//  Pinterest
//
//  Created by Anastasia Demidova on 12.05.2021.
//

import UIKit

class PhotosDataSource: NSObject {
    
    init(directory: String) {
        super.init()
        directoryName.self = directory
    }

    private var directoryName: String = "Data"
    
    private var urls: [URL] {
        Bundle.main.urls(forResourcesWithExtension: .none, subdirectory: directoryName)!
    }

    func loadImages() -> [UIImage] {
        return urls
            .compactMap { try? Data(contentsOf: $0) }
            .compactMap(UIImage.init(data:))
    }
}
