//
//  PagingView.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class PagingView: UICollectionReusableView {
    static var height: CGFloat = 44
    static let reuseIdentifier = "paging"
    
    lazy var spinnerView: UIActivityIndicatorView = {
        var pinnerview: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
             pinnerview = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            // Fallback on earlier versions
          pinnerview = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        }
        pinnerview.translatesAutoresizingMaskIntoConstraints = false
        return pinnerview
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }
    var isLoading: Bool  = false {
        didSet {
            if isLoading {
                spinnerView.startAnimating()
            } else {
                spinnerView.stopAnimating()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func configSubViews()  {
        addSubview(spinnerView)
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
