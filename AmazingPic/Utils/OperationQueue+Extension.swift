//
//  OperationQueue+Extension.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

extension OperationQueue {
    convenience init(with name: String, serial: Bool = false) {
        self.init()
        self.name = name
        if serial {
            maxConcurrentOperationCount = 1
        }
    }

    func addOperationWithDependencies(_ operation: Operation) {
        for dependencies in operation.dependencies {
            addOperationWithDependencies(dependencies)
        }
        addOperation(operation)
    }

    func cancelOperations(ofTypes types: [Operation.Type]) {
        var operationsToRemove = [Operation]()
        for operation in operations {
            if types.contains(where: { $0 == type(of: operation) }) {
                if let operation = operation as? ConcurrentOperation {
                    operation.cancelAndCompleteOperation()
                } else {
                    operation.cancel()
                }
                operationsToRemove.append(operation)
            }
        }

    }
}
