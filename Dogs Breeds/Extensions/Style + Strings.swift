//
//  Style + Appearance.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit
class Appearance {
    enum StingValues {
        
        //MARK: - Tab Bar
        
        static let tabBarListImage = "list.dash"
        static let tabBarListTitle = NSLocalizedString("List", comment: "")
        static let tabBarFavoriteImage = "heart"
        static let tabBarFavoriteSelectedImage = "heart.fill"
        static let tabBarFavoriteTitle = NSLocalizedString("Favorites", comment: "")
        
        //MARK: - Cells Indentifier
        static let tableViewCellIdentifier = "TableViewCell"
        static let collectionViewCellIdentifier = "PhotoCollectionViewCell"
        
        //MARK: - Alert Titles & Messages
        static let serverErorTitle =  NSLocalizedString("We got server error", comment: "")
        static let serverErorMessage = NSLocalizedString("Try again later", comment: "")
        static let OkActionTitle = NSLocalizedString("Ok", comment: "")
        static let shareActionTitle = NSLocalizedString("Share", comment: "")
        static let cancelActionTitle = NSLocalizedString("Cancel", comment: "")
        static let shareTitle = NSLocalizedString("Share photo", comment: "")
        
        static let favoritesPlaceholderText = NSLocalizedString("No liked photos yet", comment: "")
        static let mainTitle = NSLocalizedString("Breeds", comment: "")
        
        //MARK: - URL
        static let allBreedsURL = "https://dog.ceo/api/breeds/list/all"
        static let baseURL = "https://dog.ceo/api/breed/"
        static let imagesURL = "/images"
    }
    
    enum Settings {
        static let fontSizeDifference: CGFloat = 4
        static let tableViewCellspacing: CGFloat = 8
        
        
    }
    enum Color {
        static let standartGreyColor = UIColor.darkGray
        static let standartWhiteColor = UIColor.white
        static let standartGreenColor = UIColor.systemGreen
        static let navBarTitleTextColor = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    }
}
