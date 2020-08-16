//
//  PhotosViewController.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosViewController: UIViewController {
    
    var isRotating: Bool = false
    var fullBreed: FullBreed
    var photosModel: PhotosModelProtocol!
    var collectionView: UICollectionView!
    
    private var favouritesModel: FavouritesModelProtocol
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    private let heartButton = LikeButton()
    
    var currentPage = 0
    
    init(fullBreed: FullBreed, photosModel: PhotosModelProtocol, favouritesModel: FavouritesModelProtocol) {
        self.fullBreed = fullBreed
        self.photosModel = photosModel
        self.favouritesModel = favouritesModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateHeartButtonImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = fullBreed.subbreed == nil ? fullBreed.breed : fullBreed.subbreed
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self,
                                                            action: #selector(sharePhoto))
        activityIndicatorViewSetup()
        collectionViewSetup()
        
        photosModel.delegate = self
        photosModel.loadPhotos(of: fullBreed)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        isRotating = true
        
        coordinator.animate(alongsideTransition: { _ in
            let offsetX = CGFloat(self.currentPage) * self.collectionView.frame.width
            self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
            self.collectionView.collectionViewLayout.invalidateLayout()
            
            self.isRotating = false
        }, completion: nil)
    }
    
    private func activityIndicatorViewSetup() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(PhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: Appearance.StingValues.collectionViewCellIdentifier)
    }
    
    private func heartButtonSetup() {
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(heartButton)
        heartButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
            .isActive = true
        heartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
            .isActive = true
        
        heartButton.addTarget(nil, action: #selector(heartButtonTouchUPInside(sender:)), for: .touchUpInside)
        
        updateHeartButtonImage()
    }
    
    func setupView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        heartButtonSetup()
        
        activityIndicatorView.removeFromSuperview()
    }
    
    func updateHeartButtonImage() {
        guard let photoURL = photosModel.photos?[currentPage] else {
            return
        }
        
        let breedName = fullBreed.subbreed == nil ? fullBreed.breed : fullBreed.subbreed!
        if favouritesModel.isFavourite(breedName, photoURL) {
            heartButton.imageDidSelected()
        } else {
            heartButton.imageDidUnSelected()
        }
    }
    
    @objc func heartButtonTouchUPInside(sender: UIButton) {
        guard let photoURL = photosModel.photos?[currentPage] else {
            return
        }
        
        let breedName = fullBreed.subbreed == nil ? fullBreed.breed : fullBreed.subbreed!
        
        if favouritesModel.changePhotoStatus(breedName, photoURL) {
            heartButton.imageDidSelected()
        } else {
            heartButton.imageDidUnSelected()
        }
    }
    
    @objc func sharePhoto() {
        func share(_ action: UIAlertAction) {
            if let photoURL = photosModel.photos?[currentPage] {
                KingfisherManager.shared.retrieveImage(with: photoURL) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                        self.baseAlert(title: Appearance.StingValues.serverErorTitle,
                                       message: Appearance.StingValues.serverErorMessage,
                                       firstActionTitle: Appearance.StingValues.OkActionTitle,
                                       firstActionStyle: .default)
                    case .success(let value):
                        let activity = UIActivityViewController(activityItems: [value.image],
                                                                applicationActivities: nil)
                        self.present(activity, animated: true)
                    }
                }
            }
        }
        
        baseAlert(title: Appearance.StingValues.shareTitle,
                  message: nil,
                  firstActionTitle: Appearance.StingValues.shareActionTitle,
                  firstActionStyle: .default,
                  firstActionHandler: share,
                  secondActionTitle: Appearance.StingValues.cancelActionTitle,
                  secondActionStyle: .cancel,
                  secondActionHandler: nil)
    }
}
