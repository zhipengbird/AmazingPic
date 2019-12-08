//
//  UIFont+Theme.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation
import UIKit
struct FontTheme {
    var titleLabelFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    var subTitleLabelFont: UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
}
extension UIFont {
    static let theme = FontTheme()
}
