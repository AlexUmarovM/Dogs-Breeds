//
//  FavouritesNavigationController.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class FavouritesNavigationController: UINavigationController {
    
    private var breedsViewController: BreedsViewController
    
    init(favouritesModel: FavouritesModelProtocol) {
        let breedsModel = BreedsModel(service: FavouritesService(favouritesModel: favouritesModel))
        breedsViewController = FavouritesViewController(breedsModel: breedsModel,
                                                        favouritesModel: favouritesModel)
        
        super.init(rootViewController: breedsViewController)
        
        let image = UIImage(systemName: Appearance.StingValues.tabBarFavoriteImage)
        let selectedImage = UIImage(systemName: Appearance.StingValues.tabBarFavoriteSelectedImage)
        tabBarItem = UITabBarItem(title: Appearance.StingValues.tabBarFavoriteTitle, image: image,
                                  selectedImage: selectedImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
