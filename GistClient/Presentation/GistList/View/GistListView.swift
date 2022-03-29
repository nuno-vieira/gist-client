//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListView: UIView {
    
    lazy private var notificationMessageView: NotificationMessageView = {
        let view = NotificationMessageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    lazy private var loadingView = LoadingView()

    lazy private var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.tableFooterView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppTheme.Color.contentBackgroundColor
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.registerCell(GistListItemCell.self)
       
        addSubview(tableView)
        addSubview(notificationMessageView)
        addSubview(loadingView)

        NSLayoutConstraint.activate([
            notificationMessageView.heightAnchor.constraint(equalToConstant: 35),
            notificationMessageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            notificationMessageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notificationMessageView.topAnchor.constraint(equalTo: tableView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
        notificationMessageView.isHidden = true
    }

    func hideLoading() {
        loadingView.isHidden = true
        notificationMessageView.isHidden = true
    }

    func showError(message: String) {
        loadingView.isHidden = true
        notificationMessageView.isHidden = false
        notificationMessageView.messageLabel.text = message
    }

    func reloadData() {
        tableView.reloadData()
    }
}
