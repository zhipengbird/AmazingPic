//
//  GradientView.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class GradientView: UIView {
    struct Color {
        let color: UIColor
        let location: CGFloat
    }
    private var colors = [Color]()
    func setColors(_ color: [Color])  {
        self.colors = color
    }
    override class  var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    func updateGradient()  {
        guard let gradientLayer  = self.layer as? CAGradientLayer else { return  }
        gradientLayer.colors = colors.map{$0.color.cgColor}
        gradientLayer.locations = colors.map{$0.location} as [NSNumber]
    }
}
