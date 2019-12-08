//
//  PageDataSource.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/7.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import Foundation

protocol PageDataSouceFactory {
    func initCursor() -> SplashPageRequest.Cursor
    func request(with cursor:SplashPageRequest.Cursor) -> SplashPageRequest
}

protocol PageDataSourceDelegate: AnyObject {
    func dataSourceWillStartFetching(_ dataSource: PageDataSource)
    func dataSource(_ dataSource: PageDataSource, didFetch items:[SplashPhoto])
    func dataSource(_ dataSource: PageDataSource, didFailWithError error: Error)
}
class PageDataSource {
    enum DataSourceError: Error {
        case dataSourceIsFecthing
        case wrongItemsType(Any)
        
        var localizedDescription: String{
            switch self {
            case .dataSourceIsFecthing:
                return "The data source is already fetching."
            case .wrongItemsType(let returnedItems):
                return "The request return the wrong item type. Expecting \([SplashPhoto].self), got \(returnedItems.self)."

            }
        }
    }
    private(set) var items = [SplashPhoto]()
    private(set) var error : Error?
    private let factory: PhotosDataSouceFactory
    private var cursor: SplashPageRequest.Cursor
    private(set) var isFetching = false
    private var canFetchMore = true
    private lazy var operationQueue = OperationQueue(with: "imagePic")
    
    weak var delegate: PageDataSourceDelegate?
    
    init(with factory: PhotosDataSouceFactory) {
        self.factory = factory
        self.cursor = factory.initCursor()
    }
    func reset()  {
        operationQueue.cancelAllOperations()
        items.removeAll()
        isFetching = false
        canFetchMore = true
        cursor = factory.initCursor()
        error = nil
    }
    
    func fetchNextPage() {
        if  isFetching {
            fetchDidComplete(withItems: nil, error: DataSourceError.dataSourceIsFecthing)
            return
        }
        
        if canFetchMore  == false{
            fetchDidComplete(withItems: [], error: nil)
        }
        delegate?.dataSourceWillStartFetching(self)
        isFetching = true
        let request = factory.request(with: cursor)
        request.completionBlock = {
            if let error = request.error {
                self.isFetching = false
                self.fetchDidComplete(withItems: nil, error: error)
                return
            }
            guard let items = request.items as? [SplashPhoto] else {
                self.isFetching = false
                self.fetchDidComplete(withItems: [], error: DataSourceError.wrongItemsType(request.items))
                return
            }
            if items.count < self.cursor.perpage {
                self.canFetchMore = false
            }else {
                self.cursor = request.nextCursor()
            }
            self.items.append(contentsOf: items)
            self.isFetching = false
            self.fetchDidComplete(withItems: items, error: nil)
        }
        operationQueue.addOperationWithDependencies(request)
    }
    
    func cancelFetch() {
        operationQueue.cancelAllOperations()
        self.isFetching = false
    }
    func item(at index:Int) -> SplashPhoto? {
        guard index < items.count else { return nil }
        return items[index]
    }
    // MARK: - Private
    private func fetchDidComplete(withItems items: [SplashPhoto]?, error: Error?) {
        self.error = error
        if let error = error {
            self.delegate?.dataSource( self, didFailWithError: error)
        }else {
            let items = items ?? []
            self.delegate?.dataSource(self, didFetch: items)
        }
    }
}
