//
//  BreedsModelProtocol.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//
import Foundation

protocol BreedsModelProtocol: class {
    
    var delegate: BreedsModelDelegate! { get set }
    var service: DogsServiceProtocol { get set }
    
    var breed: Breed? { get }
    func getSubbreedsModel(_ subbreedIndex: Int) -> BreedsModelProtocol?
    
    func loadBreeds(delegate: BreedsModelDelegate)
}
