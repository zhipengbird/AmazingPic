//
//  PhotoCollectionViewCell.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCell"
    
    lazy var photoView: PhotoItemView = {
        let photoView = PhotoItemView()
        photoView.translatesAutoresizingMaskIntoConstraints = false
        return photoView
    }()
    lazy var checkMarkView = CheckMarkView()
    
    var photoItem: SplashPhoto? {
        didSet{
            if let photo = photoItem {
                photoView.configuare(with: photo)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
        updateSelectStatus()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private  func configSubViews()  {
        contentView.addSubview(photoView)
        contentView.addSubview(checkMarkView)
        
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            checkMarkView.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: 1),
            checkMarkView.bottomAnchor.constraint(equalToSystemSpacingBelow: contentView.bottomAnchor, multiplier: 1)
        ])
    }
    func updateSelectStatus()  {
        photoView.alpha = isSelected ? 0.7 : 1
        checkMarkView.alpha = isSelected ? 1 : 0
    }

    func configure(with photo: SplashPhoto)  {
        photoView.configuare(with: photo)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.prepareForReuse()
    }
}
