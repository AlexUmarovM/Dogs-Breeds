//
//  BreedsModel.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation
import Alamofire

final class BreedsModel: BreedsModelProtocol {
    
    weak var delegate: BreedsModelDelegate!
    var service: DogsServiceProtocol
    
    private(set) var breed: Breed?
    
    init(service: DogsServiceProtocol) {
        self.service = service
    }
    
    func getSubbreedsModel(_ subbreedIndex: Int) -> BreedsModelProtocol? {
        let subbreedsModel = BreedsModel(service: service)
        
        if let subbreed = breed?.subbreeds?[subbreedIndex] {
            subbreedsModel.breed = subbreed
        } else {
            return nil
        }
        
        return subbreedsModel
    }
    
    func loadBreeds(delegate: BreedsModelDelegate) {
        self.delegate = delegate
        
        service.getBreeds { breeds in
            self.breed = breeds.map(Breed.init)
            
            delegate.breedsModelDidLoad()
        }
    }
}
