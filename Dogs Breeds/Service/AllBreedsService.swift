//
//  AllBreedsService.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation
import Alamofire

struct AllBreedsService: DogsServiceProtocol {
    
    private let allBreedsURLString = Appearance.StingValues.allBreedsURL
    private func getPhotosURLStrings(for breed: FullBreed) -> String {
        Appearance.StingValues.baseURL + breed.breed.lowercased()
            + (breed.subbreed == nil ? "" : ("/" + breed.subbreed!.lowercased()))
            + Appearance.StingValues.imagesURL
    }
    
    func getBreeds(_ callback: @escaping ([Breed]?) -> Void) {
        AF.request(allBreedsURLString).validate().responseJSON { response in
            switch response.result {
            case let .failure(error):
                print(error)
                callback(nil)
            case .success:
                if let json = try? JSONDecoder().decode(BreadsResponse.self, from: response.data!) {
                    callback(json.message.map(Breed.init))
                } else {
                    callback(nil)
                }
            }
        }
    }
    
    func getPhotos(of breed: FullBreed, _ callback: @escaping ([URL]?) -> Void) {
        let url = breed.isRoot
            ? getPhotosURLStrings(for: FullBreed(breed: breed.subbreed!, subbreed: nil))
            : getPhotosURLStrings(for: breed)
        
        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case let .failure(error):
                print(error)
                callback(nil)
            case .success:
                if let json = try? JSONDecoder().decode(PhotosResponse.self, from: response.data!) {
                    callback(json.message.compactMap(URL.init(string:)))
                } else {
                    callback(nil)
                }
            }
        }
    }
    
    private struct BreadsResponse: Codable {
        let message: [String: [String]]
    }
    
    private struct PhotosResponse: Codable {
        let message: [String]
    }
}
