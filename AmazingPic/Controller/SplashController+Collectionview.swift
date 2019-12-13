//
//  SplashController+Collectionview.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation
import UIKit

extension SplashPhotoSearchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath)
        guard let photocell = cell as? PhotoCollectionViewCell, let photo = dataSource.item(at: indexPath.item) else { return cell }
        photocell.configure(with: photo)
        return photocell
    }
    
    
}
extension SplashPhotoSearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let prefetchCount = 19
        if indexPath.item == dataSource.items.count - prefetchCount {
            fectchNextItems()
        }
    }
}
extension SplashPhotoSearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let photo = dataSource.item(at: indexPath.item) else { return .zero }
        
        let width = collectionView.frame.width
        let height = CGFloat(photo.height) * width / CGFloat(photo.width)
        return CGSize(width: width, height: height)
    }
}

