//
//  UIColor+Theme.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation
import UIKit
struct Theme {
    var backgroundColor: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        }
        return .white
    }
    
    var titleLabelColor: UIColor {
        if #available(iOS 13, *) {
            return .label
        }
        return .black
    }
    
    var subTitleLabelColor: UIColor {
        if #available(iOS 13, *) {
            return .secondaryLabel
        }
        return .gray
    }
}

extension UIColor {
    static let theme = Theme()
}
