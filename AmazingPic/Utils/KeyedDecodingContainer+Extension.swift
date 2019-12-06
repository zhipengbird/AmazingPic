//
//  KeyedDecodingContainer+Extension.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/5.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation
import UIKit
extension KeyedDecodingContainer {
    func decode(_ type: UIColor.Type , forKey key: Key) throws -> UIColor {
        let hexColor = try self.decode(String.self, forKey: key)
        return UIColor(hexString: hexColor)
    }
    func decode(_ type: [SplashPhoto.URLKind: URL].Type, forKey key: Key) throws -> [SplashPhoto.URLKind: URL] {
        let urlsDictionary = try self.decode([String: String].self, forKey: key)
        var result = [SplashPhoto.URLKind: URL]()
        for (key, value) in urlsDictionary {
            if let kind = SplashPhoto.URLKind(rawValue: key),
                let url = URL(string: value) {
                result[kind] = url
            }
        }
        return result
    }
    
    func decode(_ type: [SplashPhoto.LinkKind: URL].Type, forKey key: Key) throws -> [SplashPhoto.LinkKind: URL] {
        let linksDictionary = try self.decode([String: String].self, forKey: key)
        var result = [SplashPhoto.LinkKind: URL]()
        for (key, value) in linksDictionary {
            if let kind = SplashPhoto.LinkKind(rawValue: key),
                let url = URL(string: value) {
                result[kind] = url
            }
        }
        return result
    }
    
    func decode(_ type: [SplashUser.ProfileImageSize: URL].Type, forKey key: Key) throws -> [SplashUser.ProfileImageSize: URL] {
        let sizesDictionary = try self.decode([String: String].self, forKey: key)
        var result = [SplashUser.ProfileImageSize: URL]()
        for (key, value) in sizesDictionary {
            if let size = SplashUser.ProfileImageSize(rawValue: key),
                let url = URL(string: value) {
                result[size] = url
            }
        }
        return result
    }
}
