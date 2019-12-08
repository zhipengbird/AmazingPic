//
//  CheckMarkView.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class CheckMarkView: UIView {
    
    override class var layerClass: AnyClass{
        return CAShapeLayer.self
    }
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 24, height: 24)
    }
    
   private lazy var checkmarkView: UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "checkmark")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func postitionInit()  {
            guard let shapeLayer = layer as? CAShapeLayer else { return  }
        shapeLayer.fillColor = tintColor.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0 )
        shapeLayer.shadowOpacity = 0.25
        shapeLayer.shadowRadius = 1
         addSubview(checkmarkView)
        NSLayoutConstraint.activate([
            checkmarkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let shapeLayer = layer as? CAShapeLayer else { return  }
        shapeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        shapeLayer.shadowPath = shapeLayer.path
    }
    override func tintColorDidChange() {
        super.tintColorDidChange()
        guard let shapeLayer = layer as? CAShapeLayer else { return  }
        shapeLayer.fillColor = tintColor.cgColor
    }

}
