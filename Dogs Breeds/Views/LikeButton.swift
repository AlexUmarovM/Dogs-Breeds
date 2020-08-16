//
//  HeartButton.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    
    private let backgroundImage = UIImage(systemName: Appearance.StingValues.tabBarFavoriteSelectedImage)?
        .withTintColor(.red, renderingMode: .alwaysOriginal)
    private let unSelected = UIImage(systemName: Appearance.StingValues.tabBarFavoriteSelectedImage)?
        .withTintColor(.darkGray, renderingMode: .alwaysOriginal)
    private let iSelected = UIImage(systemName: Appearance.StingValues.tabBarFavoriteSelectedImage)?
        .withTintColor(.red, renderingMode: .alwaysOriginal)
    
    private let foregroundImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(backgroundImage, for: .normal)
        setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .large), forImageIn: .normal)
        
        foregroundImageView.image = unSelected
        foregroundImageView.preferredSymbolConfiguration =
            UIImage.SymbolConfiguration(pointSize: 22, weight: .regular, scale: .large)
        addSubview(foregroundImageView)
        
        foregroundImageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageView = imageView {
            foregroundImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
            foregroundImageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        }
        
        imageDidUnSelected()
    }
    
    func imageDidUnSelected() {
        foregroundImageView.image = unSelected
    }
    
    func imageDidSelected() {
        foregroundImageView.image = iSelected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
