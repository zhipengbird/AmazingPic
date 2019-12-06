//
//  splashPageRequest.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/5.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

class SplashPageRequest: SplashRequest {
    struct Cursor {
        let page : Int
        let perpage: Int
        let parameters:[String:Any]?
    }
    
    let cursor :Cursor
    var items = [Any]()
    
    init(with cursor:Cursor) {
        self.cursor = cursor
        super.init()
    }
    convenience init(with page: Int = 1, perPage: Int = 10) {
        self.init(with: Cursor(page: page, perpage: perPage, parameters: nil))
    }
    
    func nextCursor() -> Cursor {
        return Cursor(page: cursor.page+1, perpage: cursor.perpage, parameters: cursor.parameters)
    }
    
    override func prepareParamters() -> [String : Any]? {
        var parameters = super.prepareParamters() ?? [String: Any]()
        parameters["page"] = cursor.page
        parameters["per_page"] = cursor.perpage
        
        if let cursorParameters = cursor.parameters {
            for (key ,value) in cursorParameters {
                parameters[key] = value
            }
        }
        return parameters
    }
    
}
