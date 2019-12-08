//
//  ImageDownloader.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation
import UIKit
class ImageDownloader {
    private var imageDataTask: URLSessionDataTask?
     private let cache = ImageCache.cache

     private(set) var isCancelled = false
    
    func downloadImage(with url:URL, completion:@escaping((UIImage?,Bool)->Void))  {
        guard imageDataTask == nil  else {
            return
        }
        isCancelled = false
        
        if let cacheResponse = cache.cachedResponse(for: URLRequest(url: url)),
            let image = UIImage(data: cacheResponse.data) {
            completion(image,true)
            return
        }
        
        imageDataTask = URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
            guard let self = self else {
                return
            }
            self.imageDataTask = nil
            guard let data = data,
                let response = response,
                let image = UIImage(data: data), error == nil else {
                return
            }
            let cacheResponse = CachedURLResponse(response: response, data: data)
            self.cache.storeCachedResponse(cacheResponse, for: URLRequest(url: url))
            
            DispatchQueue.main.async {
                completion(image,false)
            }
            
            
        })
        imageDataTask?.resume()
    }
    func cancel()  {
        isCancelled = true
        imageDataTask?.cancel()
    }
}
