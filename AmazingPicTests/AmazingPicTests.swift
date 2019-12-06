//
//  AmazingPicTests.swift
//  AmazingPicTests
//
//  Created by yuanpinghua on 2019/12/3.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import XCTest
@testable import AmazingPic

class AmazingPicTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let except  =  self.expectation(description: "asyn")
    
//        Configuration.shared = UnsplashPhotoConfiguration(accessKey: "b2f4e2589e116c4b9fb0560f402a8120ef55bedf3b13fffd621fc10eade48155", secretkey: "e586f8df794684789065ddf077de58d32c52c78e6b9f069064271360bf52dfda", query: "", allowMultipleSelection: false , memoryCapacity: 100, diskCapacity: 100)
//        
       let request  = CollectionPhotosRequest(for: "12", page: 1, perpage: 10)
        request.completionBlock = {
            except.fulfill()
        }
        request.start()
        self.waitForExpectations(timeout: 100) { (error) in
            print(error ?? "")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
