//
//  ConcurrentOperation.swift
//  AmazingPic
//
//  Created by yuanpinghua on 2019/12/3.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class ConcurrentOperation: Operation {
    var error: Error?
    override init() {
        overrideFinished = false
        overrideExecuting = false
        super.init()
    }
    override func start() {
        isExecuting = true 
        if isCancelled || hasCanceledDependency() {
            cancelAndCompleteOperation()
            return 
        }
        
        main()
    }
    func completeOperation() {
        isExecuting = false
        isFinished = true
    }
    final func completeWithError(_ error: Error)  {
        self.error = error
        cancelAndCompleteOperation()
    }
    func cancelAndCompleteOperation()  {
        cancel()
        completeOperation()
    }
    
    private var overrideExecuting: Bool
    override var isExecuting: Bool {
        get { return overrideExecuting }
        set {
            willChangeValue(forKey: "isExecuting")
            overrideExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    private var overrideFinished: Bool 
    override var isFinished: Bool{
        get { return overrideFinished }
        set {
            willChangeValue(forKey: "isFinished")
            overrideFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
}

extension Operation {
    func hasCanceledDependency() -> Bool {
        for operation in dependencies where operation.isCancelled {
            return true
        }
        return false
    }
}
