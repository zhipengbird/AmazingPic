//
//  ImageCache.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/4.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

class ImageCache {
     static let cache = URLCache(memoryCapacity: memoryCapacity, 
                                 diskCapacity: diskCapacity, 
                                 diskPath: "Image")
    
    static let memoryCapacity: Int = 50.megabytes
    static let diskCapacity: Int = 100.megabytes
}

private extension Int {
    var megabytes: Int { return self * 1024 * 1024 }
}

