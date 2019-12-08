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
    
    var dataSource:PageDataSource {
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
    
    //MARK: init
    init() {
        self.dataSource = editorialDataSource
        super.init(nibName: nil, bundle: nil)
        self.dataSource.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    //MARK: - 交互方法
    @objc func cancelBarButtonDidClicked(sender: UIBarButtonItem)  {
        
    }
    @objc func doneBarButtonDidClicked(sender: UIBarButtonItem)  {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
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
        self.title = String(format: NSLocalizedString("title", comment: ""), numberOfSelectedPhoto)
    }
    
}

//MARK: - 搜索代理
extension SplashPhotoSearchViewController: UISearchBarDelegate{
    
}

extension SplashPhotoSearchViewController: UISearchControllerDelegate{
    
}

extension SplashPhotoSearchViewController: PageDataSourceDelegate{
    func dataSourceWillStartFetching(_ dataSource: PageDataSource) {
        
    }
    
    func dataSource(_ dataSource: PageDataSource, didFetch items: [SplashPhoto]) {
        <#code#>
    }
    
    func dataSource(_ dataSource: PageDataSource, didFailWithError error: Error) {
        <#code#>
    }
    
    
}
