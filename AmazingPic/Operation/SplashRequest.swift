//
//  SplashRequest.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/5.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class SplashRequest: NetworkRequest {
    enum RequestError: Error {
        case invalidJsonResponse
        var localizedDescription: String {
            switch self {
                case .invalidJsonResponse:
                return "Invalid Json response"
            }
        }
    }
    //带有私有设置方法的公开属性
   private(set)  var jsonResponse:Any?
    
    override func prepareURLComponents() -> URLComponents? {
        guard let apiURL = URL(string: Configuration.shared.apiURL) else { return nil }
        
        var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = endPoint
        return urlComponents
    }
    override func prepareParamters() -> [String : Any]? {
        return nil
    }
    override func prepareHeaders() -> [String : String]? {
        var headers = [String:String]()
        headers["authorization"] = "Client-ID \(Configuration.shared.accessKey)"
        return headers
    }
    override func processResponseData(_ data: Data?) {
        if let error = error {
            completeWithError(error)
            return
        }
        guard let data = data else { return  }
        
        do {
            jsonResponse =  try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
        } catch  {
            completeWithError(RequestError.invalidJsonResponse)
        }
    }
    func processJsonResponse() {
        if let error = error {
            completeWithError(error)
        }else {
            completeOperation()
        }
    }
    
}
