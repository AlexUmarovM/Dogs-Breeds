//
//  DogsServiceProtocol.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

protocol DogsServiceProtocol {
    
    func getBreeds(_ callback: @escaping ([Breed]?) -> Void)
    func getPhotos(of breed: FullBreed, _ callback: @escaping ([URL]?) -> Void)
}
