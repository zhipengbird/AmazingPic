//
//  File.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/5.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

class CollectionPhotosRequest: SplashPageRequest {
   static func cursor(with collectionId: String, page: Int = 1, pergage: Int = 1) -> SplashPageRequest.Cursor {
        let parameters: [String:Any] = ["id":collectionId]
        return Cursor(page: page, perpage: pergage, parameters: parameters)
    }
    convenience init(for collectionId:String, page:Int = 1, perpage:Int = 1) {
        let cursor = CollectionPhotosRequest.cursor(with: collectionId, page: page, pergage: perpage)
        self.init(with: cursor)
    }
    private let collectionId: String
    override init(with cursor: Cursor) {
        if let parameters = cursor.parameters {
            if let collectionId = parameters["id"] as? String {
                self.collectionId = collectionId
            }else {
                self.collectionId = ""
            }
        } else {
            self.collectionId = ""   
        }
        super.init(with: cursor)
    }
    override var endPoint: String{
        return "/collections/\(collectionId)/photos"
    }
    
    override func prepareParamters() -> [String : Any]? {
        var parameters = super.prepareParamters()
        parameters?["id"] = nil
        return parameters
    }
    
    override func processResponseData(_ data: Data?) {
        if let data = data {
            do {
                let result = try? JSONSerialization.jsonObject(with: data, options: [])
                print(result)          
                completeOperation()
            } catch  {
                self.error = error
            }
          
        }
        super.processResponseData(data)
    }
//    func photosFromResponseData(_ data: Data?) -> [Any]? {
//        guard let data = data else {
//            return nil 
//        }
//        do {
////            return try  JSONDecoder().decode([].self, from: data)
//        } catch  {
//            self.error = error
//            return nil
//        }
//    }
    
}
