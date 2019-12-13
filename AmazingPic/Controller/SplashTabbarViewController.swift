//
//  SplashTabbarViewController.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/11.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class SplashTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let splashVC = SplashPhotoSearchViewController()
        splashVC.tabBarItem.title = "Image"
        if #available(iOS 13, *) {
            splashVC.tabBarItem.image = UIImage.init(systemName: "hare")
            splashVC.tabBarItem.selectedImage = UIImage.init(systemName: "hare.fill")
        } else {
            splashVC.tabBarItem.image = UIImage(named: "Circle-icons-image")
            splashVC.tabBarItem.selectedImage = UIImage(named: "Circle-icons-image")
        }
        self.viewControllers = [UINavigationController(rootViewController: splashVC)]
    }
    
}
