//
//  UnsplashPhotoConfiguration.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/4.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

struct Configuration {
    static var shared: UnsplashPhotoConfiguration = UnsplashPhotoConfiguration()
}

struct UnsplashPhotoConfiguration {
    ///Your application's access key
    public var accessKey = "b2f4e2589e116c4b9fb0560f402a8120ef55bedf3b13fffd621fc10eade48155"
    ///Your application's secret key
    public var secretkey = "e586f8df794684789065ddf077de58d32c52c78e6b9f069064271360bf52dfda"
    
    /// A search query. When set, hides the search bar and shows results instead of the editorial photos.
    public var query: String?
    
    /// Controls whether the picker allows multiple or single selection.
    public var allowMultipleSelection = false
    
    ///The memory capacity used by the cache
    public var memoryCapacity =  defaultMemoryCapacity
    /// The disk capacity user by the cache
    public var diskCapacity =  defaultDiskCapacity
    
    /// The default memory capacity used by the cache.
    public static let defaultMemoryCapacity: Int =  ImageCache.memoryCapacity
    /// The default disk capacity used by the cache.
    public static let defaultDiskCapacity: Int = ImageCache.diskCapacity
    
    /// The Unsplash API url.
    let apiURL = "https://api.unsplash.com/"
    
    /// The Unsplash editorial collection id.
    let editorialCollectionId = "317099"
    
}
