//
//  FavouritesViewController.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

import UIKit

final class FavouritesViewController: BreedsViewController {
    
    private let emptyLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    override func setupView() {
        emptyLabel.text = Appearance.StingValues.favoritesPlaceholderText
        emptyLabel.textColor = Appearance.Color.standartWhiteColor
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyLabel)
        view.backgroundColor = Appearance.Color.standartGreyColor
        emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        super.setupView()
    }
    
    private func updateView() {
        breedsModel.loadBreeds(delegate: self)
        if let count = breedsModel.breed?.subbreeds?.count,
            count != 0 {
            emptyLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            emptyLabel.isHidden = false
            tableView.isHidden = true
        }
    }
}


