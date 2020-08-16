//
//  Extensions.swift
//  Dogs Breeds
//
//  Created by Александр Умаров on 16.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import UIKit

//MARK: - BreedsViewController Extensions

extension BreedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breedsModel.breed?.subbreeds?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Appearance.StingValues.tableViewCellIdentifier,
                                                       for: indexPath) as? TableViewCell else {
                                                        return TableViewCell()
        }
        
        if let subbreed = breedsModel.breed?.subbreeds?[indexPath.row] {
            cell.textLabel?.text = subbreed.name
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .darkGray
            cell.textLabel?.textColor = .white
            if let subbreeds = subbreed.subbreeds {
                let ending = subbreeds.count == 1 ? "" : "s"
                cell.secondaryLabel.text = "(\(subbreeds.count) subbreed\(ending))"
            }
        }
        
        return cell
    }
}

extension BreedsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let subbreedsModel = breedsModel.getSubbreedsModel(indexPath.row),
            let subbreed = subbreedsModel.breed else {
                return
        }
        
        if subbreed.subbreeds != nil {
            let subbreedsViewController = BreedsViewController(breedsModel: subbreedsModel,
                                                               favouritesModel: favouritesModel)
            subbreedsViewController.fullBreed = FullBreed(breed: subbreed.name, subbreed: nil)
            
            navigationController?.pushViewController(subbreedsViewController, animated: true)
        } else {
            let fullBreed: FullBreed =
                self.fullBreed == nil
                    ? FullBreed(breed: subbreed.name, subbreed: nil)
                    : FullBreed(breed: self.fullBreed!.breed, subbreed: subbreed.name)
            
            let photosModel = PhotosModel(service: breedsModel.service)
            let photosViewController = PhotosViewController(fullBreed: fullBreed,
                                                            photosModel: photosModel,
                                                            favouritesModel: favouritesModel)
            
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}

extension BreedsViewController: BreedsModelDelegate {
    func breedsModelDidLoad() {
        DispatchQueue.main.async {
            guard self.breedsModel.breed != nil else {
                self.baseAlert(title: Appearance.StingValues.serverErorTitle,
                               message: Appearance.StingValues.serverErorMessage,
                               firstActionTitle: Appearance.StingValues.OkActionTitle,
                               firstActionStyle: .default)
                
                return
            }
            
            self.setupView()
        }
    }
    func baseAlert(title: String? = nil,
                   message: String? = nil,
                   firstActionTitle: String? = nil,
                   firstActionStyle: UIAlertAction.Style? = nil,
                   firstActionHandler: ((UIAlertAction) -> Void)? = nil,
                   secondActionTitle: String? = nil,
                   secondActionStyle: UIAlertAction.Style? = nil,
                   secondActionHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: firstActionTitle, style: firstActionStyle ?? .default, handler: firstActionHandler)
        alertController.addAction(firstAlertAction)
        
        let secondAlertAction = UIAlertAction(title: secondActionTitle, style: secondActionStyle ?? .default, handler: secondActionHandler)
        alertController.addAction(secondAlertAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

//MARK: - PhotosViewController Extensions

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isRotating {
            return
        }
        
        currentPage = Int(round(collectionView.contentOffset.x / collectionView.frame.width))
        updateHeartButtonImage()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosModel.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Appearance.StingValues.collectionViewCellIdentifier,
            for: indexPath) as? PhotoCollectionViewCell else {
                return PhotoCollectionViewCell()
        }
        
        if let photoURL = photosModel.photos?[indexPath.row] {
            cell.setImage(photoURL) { result in
                if case .failure(let error) = result {
                    print(error)
                    self.baseAlert(title: Appearance.StingValues.serverErorTitle,
                    message: Appearance.StingValues.serverErorMessage,
                    firstActionTitle: Appearance.StingValues.OkActionTitle,
                    firstActionStyle: .default)
                }
            }
        }
        
        return cell
    }
}

extension PhotosViewController: PhotosModelDelegate {
    func photosModelDidLoad() {
        DispatchQueue.main.async {
            updateView()
        }
        
        func updateView() {
            guard photosModel.photos != nil else {
                baseAlert(title: Appearance.StingValues.serverErorTitle,
                message: Appearance.StingValues.serverErorMessage,
                firstActionTitle: Appearance.StingValues.OkActionTitle,
                firstActionStyle: .default) { _ in
                    self.photosModel.loadPhotos(of: self.fullBreed)
                }
                
                return
            }
            
            setupView()
        }
    }

   public func baseAlert(title: String? = nil,
                   message: String? = nil,
                   firstActionTitle: String? = nil,
                   firstActionStyle: UIAlertAction.Style? = nil,
                   firstActionHandler: ((UIAlertAction) -> Void)? = nil,
                   secondActionTitle: String? = nil,
                   secondActionStyle: UIAlertAction.Style? = nil,
                   secondActionHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: firstActionTitle, style: firstActionStyle ?? .default, handler: firstActionHandler)
        alertController.addAction(firstAlertAction)
        
        let secondAlertAction = UIAlertAction(title: secondActionTitle, style: secondActionStyle ?? .default, handler: secondActionHandler)
        alertController.addAction(secondAlertAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

//MARK: - FavouritesViewController Extensions

extension FavouritesViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Appearance.StingValues.tableViewCellIdentifier,
                                                       for: indexPath) as? TableViewCell
            else {
                return TableViewCell()
        }
        
        if let breed = breedsModel.breed?.subbreeds?[indexPath.row] {
            cell.textLabel?.text = breed.name
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .darkGray
            cell.textLabel?.textColor = .white
            let count = favouritesModel.photosCount(breed.name)
            let ending = count == 1 ? "" : "s"
            cell.secondaryLabel.text = "(\(count) photo\(ending))"
        }
        
        return cell
    }
}

extension FavouritesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let subbreedsModel = breedsModel.getSubbreedsModel(indexPath.row),
            let subbreed = subbreedsModel.breed else {
                return
        }
        
        let fullBreed: FullBreed = FullBreed(breed: subbreed.name, subbreed: nil)
        
        let photosModel = PhotosModel(service: breedsModel.service)
        let photosViewController = PhotosViewController(fullBreed: fullBreed,
                                                        photosModel: photosModel,
                                                        favouritesModel: favouritesModel)
        
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}
