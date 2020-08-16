//
//  BreedsViewController.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController {
    
    var fullBreed: FullBreed? = nil
    var breedsModel: BreedsModelProtocol!
    var favouritesModel: FavouritesModelProtocol
    
    let tableView = UITableView(frame: .zero, style: .plain)
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init(breedsModel: BreedsModelProtocol, favouritesModel: FavouritesModelProtocol) {
        self.breedsModel = breedsModel
        self.favouritesModel = favouritesModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if (breedsModel.breed == nil) {
            breedsModel.loadBreeds(delegate: self)
        } else {
            setupView()
        }
        
    }
    
    func setupView() {
        activityIndicatorView.removeFromSuperview()
        navigationItem.title = breedsModel.breed?.name
        navigationController?.navigationBar.barTintColor = Appearance.Color.standartGreenColor
        navigationController?.navigationBar.tintColor = Appearance.Color.standartGreyColor
        navigationController?.navigationBar.titleTextAttributes = Appearance.Color.navBarTitleTextColor
        tabBarController?.tabBar.barTintColor = Appearance.Color.standartGreyColor
        tabBarController?.tabBar.tintColor = Appearance.Color.standartWhiteColor
        tableView.backgroundColor = Appearance.Color.standartGreyColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Appearance.StingValues.tableViewCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
