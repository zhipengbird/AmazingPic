//
//  NSError+Extension.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/9.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

extension NSError {
    func isNoInternetConnectionError() -> Bool {
        let noInternetConnectionErrorCodes = [
            NSURLErrorNetworkConnectionLost,
            NSURLErrorNotConnectedToInternet,
            NSURLErrorInternationalRoamingOff,
            NSURLErrorCallIsActive,
            NSURLErrorDataNotAllowed
        ]
        
        if domain == NSURLErrorDomain && noInternetConnectionErrorCodes.contains(code) {
            return true
        }
        
        return false
    }
}
