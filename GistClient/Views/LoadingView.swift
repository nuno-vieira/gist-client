//
//  LoadingView.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 19/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.Theme.contentBackgroundColor
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
