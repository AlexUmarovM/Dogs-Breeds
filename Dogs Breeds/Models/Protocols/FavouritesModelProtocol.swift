//
//  File.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

protocol FavouritesModelProtocol: class {
    
    var breeds: [Breed] { get }
    
    func getPhotos(by name: String) -> [URL]
    
    func photosCount(_ name: String) -> Int
    
    func isFavourite(_ name: String, _ photoURL: URL) -> Bool

    func changePhotoStatus(_ name: String, _ photoURL: URL) -> Bool
}
