//
//  SplashPhotoSearchViewController.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

class SplashPhotoSearchViewController: UIViewController {
    //MARK:- 属性
    
    private lazy var cancelBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarButtonDidClicked(sender:)))
    }()
    private lazy var doneBarButtonItem: UIBarButtonItem = {
        
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonDidClicked(sender:)))
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        return searchController
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        collectionView.register(PagingView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingView.reuseIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.backgroundColor = UIColor.theme.backgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        return emptyView
    }()
    
    var dataSource:PageDataSource =  PhotosDataSouceFactory.collection(identifier: Configuration.shared.editorialCollectionId).dataSource {
        didSet{
            oldValue.cancelFetch()
            dataSource.delegate = self
        }
    }
    var numberOfSelectedPhoto : Int {
        return self.collectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    private let editorialDataSource = PhotosDataSouceFactory.collection(identifier: Configuration.shared.editorialCollectionId).dataSource
    
    private var searchString: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.dataSource = editorialDataSource
        self.dataSource.delegate = self
//        configNavigationBar()
        configSearchBar()
        configSubviews()
        
    }
    func configNavigationBar()  {
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
        if Configuration.shared.allowMultipleSelection {
            self.navigationItem.rightBarButtonItem = doneBarButtonItem
            doneBarButtonItem.isEnabled = false
        }
    }
    
    func configSearchBar() {
        let trimmedQuery = Configuration.shared.query?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let query = trimmedQuery, query.isEmpty == false { return }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        
    }
    func configSubviews()  {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func hiddenEmptyView() {
        self.emptyView.isHidden = true
    }
    func updateEmptyViewStatus(with state: EmptyViewState)  {
        emptyView.state = state
        emptyView.isHidden = false
        spinner.stopAnimating()
    }
    
    func updateTitle() {
//        self.title = String(format: NSLocalizedString("title", comment: ""), numberOfSelectedPhoto)
    }
    
    func setSearchText(_ text: String?)  {
        if let text = text, text.isEmpty == false {
            dataSource = PhotosDataSouceFactory.search(query: text).dataSource
            searchString = text
        } else {
            dataSource = editorialDataSource
            searchString = ""
        }
    }
}
//MARK: 交互
extension SplashPhotoSearchViewController {
    //MARK: - 交互方法
    @objc func cancelBarButtonDidClicked(sender: UIBarButtonItem)  {
        
    }
    @objc func doneBarButtonDidClicked(sender: UIBarButtonItem)  {
        
    }
    
    @objc func refresh() {
        guard dataSource.items.isEmpty else {
            return
        }
        if dataSource.isFetching == false && dataSource.items.isEmpty {
            dataSource.reset()
            reloadData()
            fectchNextItems()
        }
    }
    func reloadData()  {
        collectionView.reloadData()
    }
    func fectchNextItems()  {
        dataSource.fetchNextPage()
    }
    
}
//MARK: - 搜索代理
extension SplashPhotoSearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return  }
        setSearchText(text)
        refresh()
        hiddenEmptyView()
        updateTitle()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.isEmpty  else { return  }
        setSearchText(nil)
        refresh()
        hiddenEmptyView()
        updateTitle()
    }
}

extension SplashPhotoSearchViewController: UISearchControllerDelegate{
    
}

extension SplashPhotoSearchViewController: PageDataSourceDelegate{
    func dataSourceWillStartFetching(_ dataSource: PageDataSource) {
        if dataSource.items.isEmpty {
            spinner.startAnimating()
        }
    }
    
    func dataSource(_ dataSource: PageDataSource, didFetch items: [SplashPhoto]) {
        spinner.stopAnimating()
        guard  !dataSource.items.isEmpty else { 
            self.updateEmptyViewStatus(with: .noResults)
            return 
        }
        
        let newItemsCount = items.count
        let startIndex = self.dataSource.items.count - newItemsCount
        let endIndex = startIndex + newItemsCount
        var indexPaths = [IndexPath]()
        for index in startIndex ..< endIndex {
            indexPaths.append(IndexPath(item: index, section: 0))
        }
        
        self.hiddenEmptyView()
        let hasWindow = self.collectionView.window != nil 
        let collectionItemCount = self.collectionView.numberOfItems(inSection: 0)
        if hasWindow &&  collectionItemCount < dataSource.items.count , collectionItemCount > 0{
            self.collectionView.insertItems(at: indexPaths)
        }else {
            self.reloadData()
        }
        
    }
    
    func dataSource(_ dataSource: PageDataSource, didFailWithError error: Error) {
        spinner.stopAnimating()
        let state: EmptyViewState = (error as NSError).isNoInternetConnectionError() ? .noInternetConnection : .serverError
        updateEmptyViewStatus(with: state)

    }
    
    
}
