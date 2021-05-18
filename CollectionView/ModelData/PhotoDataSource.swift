//
//  PhotoDataSource.swift
//  Pinterest
//
//  Created by Anastasia Demidova on 12.05.2021.
//

import UIKit

class PhotosDataSource {
    private var directoryName: String?
    
    init(directory: String) {
        directoryName = directory
    }
    
    private var urls: [URL] {
        guard let name = directoryName,
              let urls = Bundle.main.urls(forResourcesWithExtension: .none,
                                          subdirectory: name) else { return [] }
        return urls
    }
    
    func loadImages() -> [UIImage] {
        return urls
            .compactMap { try? Data(contentsOf: $0) }
            .compactMap(UIImage.init(data:))
    }
}
