//
//  EmptyView.swift
//  AmazingPic
//
//  Created by 袁平华 on 2019/12/8.
//  Copyright © 2019 yuanpinghua. All rights reserved.
//

import UIKit

enum EmptyViewState {
    case noResults
    case noInternetConnection
    case serverError
    var title: String {
        switch self {
        case .noResults:
            return NSLocalizedString("error.noResults.title", comment: "")
        case .noInternetConnection :
            return NSLocalizedString("error.noInternetConnection.title", comment: "")
        case .serverError:
            return NSLocalizedString("error.serverError.title", comment: "")
        }
    }
    var description: String {
        switch self {
            
        case .noResults:
            return NSLocalizedString("error.noResults.description", comment: "")
        case .noInternetConnection :
            return NSLocalizedString("error.noInternetConnection.description", comment: "")
        case .serverError:
            return NSLocalizedString("error.serverError.description", comment: "")
        }
    }
    
}

class EmptyView: UIView {
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.titleLabelColor
        label.font = UIFont.theme.titleLabelFont
        
        return label
    }()
    lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme.subTitleLabelFont
        label.textColor = UIColor.theme.subTitleLabelColor
        return label
    }()
    
    var state: EmptyViewState? {
        didSet {
            //TODO: 更新内容
            setupState()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func configSubViews()  {
        backgroundColor = UIColor.theme.backgroundColor
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionTitleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:containerView.topAnchor, constant: Constants.padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.margin),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.margin),
        ])
        
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo:titleLabel.topAnchor, constant: Constants.padding),
              descriptionTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.margin),
              descriptionTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.margin),
              descriptionTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
          ])
    }
    
    private func setupState() {
        titleLabel.text = state?.title
        descriptionTitleLabel.text = state?.description
    }
}
// MARK: - Constants
private extension EmptyView {
    struct Constants {
        static let margin: CGFloat = 20.0
        static let padding: CGFloat = 10.0
    }
}
