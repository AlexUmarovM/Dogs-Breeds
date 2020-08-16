//
//  PhotosModel.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

final class PhotosModel: PhotosModelProtocol {
    
    var delegate: PhotosModelDelegate!
    var service: DogsServiceProtocol
    
    // nil means error
    private(set) var photos: [URL]?
    
    init(service: DogsServiceProtocol) {
        self.service = service
    }
    
    func loadPhotos(of breed: FullBreed) {
        service.getPhotos(of: breed) { photos in
            self.photos = photos
            
            self.delegate.photosModelDidLoad()
        }
    }
}
