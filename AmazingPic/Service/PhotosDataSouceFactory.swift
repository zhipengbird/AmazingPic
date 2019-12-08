//
//  PhotosDataSouceFactory.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

enum PhotosDataSouceFactory: PageDataSouceFactory {
    case search(query: String)
    case collection(identifier: String)
    var dataSource: PageDataSource {
        return PageDataSource(with: self)
    }
    
    func initCursor() -> SplashPageRequest.Cursor {
        switch self {
        case .search(let query):
            return SearchPhotoRequest.cursor(with: query, page: 1, perpage: 30)
            
            
        case .collection( let indentifier):
            return CollectionPhotosRequest.cursor(with: indentifier, page: 1, pergage: 30)
            
        }
    }
    
    func request(with cursor: SplashPageRequest.Cursor) -> SplashPageRequest {
        switch self {
        case .search( let query):
            return SearchPhotoRequest(with: query, page: cursor.page, perpage: cursor.perpage)
        case .collection(let indentifier):
            return CollectionPhotosRequest(for: indentifier, page: cursor.page, perpage: cursor.perpage)
        }
    }
    
    
}
