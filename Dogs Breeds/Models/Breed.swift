//
//  Breed.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

struct Breed {
    
    let name: String
    var subbreeds: [Breed]? = nil
    
    fileprivate static let mainTitle = Appearance.StingValues.mainTitle
    
    init(name: String) {
        self.name = name.capitalized
    }
    
    init(subbreeds: [Breed]?) {
        self.init(name: Breed.mainTitle, subbreeds: subbreeds)
    }
    
    init(name: String, subbreeds: [Breed]?) {
        self.name = name.capitalized
        
        if let sub = subbreeds, !sub.isEmpty {
            self.subbreeds = sub.sorted{$0.name < $1.name}
        }
    }
    
    init(name: String, subbreeds: [String]) {
        self.init(name: name, subbreeds: subbreeds.map(\.capitalized).map(Breed.init))
    }
}

struct FullBreed: Hashable {
    let breed: String
    let subbreed: String?
    
    var isRoot: Bool {
        breed == Breed.mainTitle
    }
}
