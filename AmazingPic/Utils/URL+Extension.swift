//
//  URL+Extension.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation
extension URL {
    func append(queryItems: [URLQueryItem]) -> URL {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return self }
        
        var queryDictionary = [String : String]()
        if let queryItems = components.queryItems {
            for item in queryItems {
                queryDictionary[item.name] = item.value
            }
        }
        for item in queryItems {
            queryDictionary[item.name] = item.value
        }
        var newComponents = components
        newComponents.queryItems = queryDictionary.map({
            URLQueryItem(name: $0.key, value: $0.value )
        })
        return newComponents.url ?? self
    }
}
