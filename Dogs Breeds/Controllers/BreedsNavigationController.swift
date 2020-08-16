//
//  BreedsNavigationController.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class BreedsNavigationController: UINavigationController {
    
    init(favouritesModel: FavouritesModelProtocol) {
        let breedsModel = BreedsModel(service: AllBreedsService())
        let breedsViewController = BreedsViewController(breedsModel: breedsModel,
                                                        favouritesModel: favouritesModel)
        
        super.init(rootViewController: breedsViewController)
        
        let image = UIImage(systemName: Appearance.StingValues.tabBarListImage)
        tabBarItem = UITabBarItem(title: Appearance.StingValues.tabBarListTitle, image: image, tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
