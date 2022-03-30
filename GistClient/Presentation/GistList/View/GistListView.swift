//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListView: UIView {

    var onErrorRetry: (() -> Void)? {
        didSet {
            errorView.retryAction = onErrorRetry
        }
    }

    lazy private var loadingView = LoadingView()

    lazy private var errorView = ErrorView()

    lazy private var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.tableFooterView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppTheme.Color.contentBackground
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.registerCell(GistListItemCell.self)

        [tableView, errorView, loadingView].forEach {
            addSubview($0)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                $0.topAnchor.constraint(equalTo: topAnchor),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }

    func configure(delegate: UITableViewDelegate) {
        tableView.delegate = delegate
    }

    func showLoading() {
        loadingView.isHidden = false
        errorView.isHidden = true
    }

    func hideLoading() {
        loadingView.isHidden = true
        errorView.isHidden = true
    }

    func showError() {
        loadingView.isHidden = true
        errorView.isHidden = false
    }

    func reloadData() {
        tableView.reloadData()
    }
}
