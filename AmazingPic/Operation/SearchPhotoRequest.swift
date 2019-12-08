//
//  SearchPhotoRequest.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class SearchPhotoRequest: SplashPageRequest {
   static func cursor(with query: String, page:Int = 1, perpage:Int = 1 ) -> SplashPageRequest.Cursor{
        return Cursor(page: page, perpage: perpage, parameters: ["query": query])
    }
    convenience init(with query: String, page:Int = 1, perpage:Int = 1 ) {
        let cursor = SearchPhotoRequest.cursor(with: query, page: page, perpage: perpage)
        self.init(with: cursor)
    }
    //MARK: prepare request
    override var endPoint: String {
        return "/search/photos"
    }
    override func processJsonResponse() {
        if let photos  = photosFromResponseData() {
            self.items = photos
            print(items)
        }
        super.processJsonResponse()
    }
    func photosFromResponseData() -> [SplashPhoto]? {
        guard let jsonResponse = jsonResponse as?[String: Any],
            let results = jsonResponse["results"] as? [Any]  else { return  nil }
        do {
            let data = try JSONSerialization.data(withJSONObject: results, options: [])
            return  try JSONDecoder().decode([SplashPhoto].self, from: data)
        } catch  {
            self.error = error
        }
        return nil
    }
}
