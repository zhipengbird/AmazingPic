//
//  ViewController.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/3.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let request  = CollectionPhotosRequest(for: "12", page: 1, perpage: 10)
//        request.completionBlock = {
//        }
//        request.start()
        // Do any additional setup after loading the view.
    }


    @IBAction func showPhoto(_ sender: Any) {
        let photoVC = SplashPhotoSearchViewController()
        let nav = UINavigationController(rootViewController: photoVC)
        self.present(nav, animated: true) { 
            
        }
    }
}

