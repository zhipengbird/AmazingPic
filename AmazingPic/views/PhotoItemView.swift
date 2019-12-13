//
//  PhotoItemView.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation
import UIKit
class PhotoItemView: UIView {
    private let imageView = UIImageView()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var gradientView: GradientView = GradientView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //MARK:: 私有方法
    private  func configSubViews()  {
        addSubview(imageView)
        addSubview(gradientView)
        addSubview(userNameLabel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientView.topAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 5),
            userNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5),
            userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    //MARK: 公开方方法
    func configuare(with photo: SplashPhoto, showUserName: Bool = true) {
        self.userNameLabel.isHidden = !showUserName
        self.userNameLabel.text = photo.user.displayName
        self.imageView.backgroundColor = photo.color
        downloadImage(with: photo)
    }
    func prepareForReuse()  {
        self.imageView.image = nil
        self.imageDownloader.cancel()
        self.userNameLabel.text = nil
        self.imageView.backgroundColor = .clear
    }
    
    //MARK:: private
   private var imageDownloader = ImageDownloader()
   private  func downloadImage(with photo: SplashPhoto)  {
        guard let regularURL = photo.urls[.regular] else { return }
        let url = sizeImageForURL(regularURL)
        imageDownloader.downloadImage(with: url) { [weak self](image, cache) in
            guard let self = self , self.imageDownloader.isCancelled == false else {
                return
            }
            if cache {
                self.imageView.image = image
            } else {
                UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    self.imageView.image = image
                }) { (complete) in
                    
                }
            }
        }
    }
    
    private var scale: CGFloat {
        return UIScreen.main.scale
    }
    
    private func sizeImageForURL(_ url: URL) -> URL {
        let width = frame.width * scale
        let height = frame.height * scale
        return  url.append(queryItems:
            [URLQueryItem(name: "max-w", value: "\(width)"),
             URLQueryItem(name: "max-h", value: "\(height)")
        ])
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let fontSize = traitCollection.horizontalSizeClass == .compact ? 10: 13
        userNameLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
}
