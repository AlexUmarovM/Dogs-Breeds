//
//  ViewController.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let favouritesModel = FavouritesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let breedsNavigationController = BreedsNavigationController(favouritesModel: favouritesModel)
        let favouritesNavigationController = FavouritesNavigationController(favouritesModel: favouritesModel)
        
        setViewControllers([breedsNavigationController, favouritesNavigationController], animated: true)
    }
}

