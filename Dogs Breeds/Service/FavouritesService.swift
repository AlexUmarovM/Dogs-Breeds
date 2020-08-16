//
//  FavouritesService.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

struct FavouritesService: DogsServiceProtocol {
    
    private weak var favouritesModel: FavouritesModelProtocol?
    
    init(favouritesModel: FavouritesModelProtocol) {
        self.favouritesModel = favouritesModel
    }
    
    func getBreeds(_ callback: @escaping ([Breed]?) -> Void) {
        callback(favouritesModel?.breeds)
    }
    
    func getPhotos(of breed: FullBreed, _ callback: @escaping ([URL]?) -> Void) {
        let name = breed.subbreed == nil ? breed.breed : breed.subbreed!
        callback(favouritesModel?.getPhotos(by: name))
    }
}
