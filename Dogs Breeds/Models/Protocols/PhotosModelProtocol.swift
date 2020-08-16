//
//  PhotosModelProtocol.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

protocol PhotosModelProtocol: class {
    
    var delegate: PhotosModelDelegate! { get set }
    var service: DogsServiceProtocol { get set }
    
    var photos: [URL]? { get }
    
    func loadPhotos(of breed: FullBreed)
}
