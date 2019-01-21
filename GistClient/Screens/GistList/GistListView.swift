//
//  GistListView.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 15/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit
import SnapKit

class GistListView: UIView {
    
    lazy var notificationMessageView: NotificationMessageView = {
        let view = NotificationMessageView(frame: .zero)
        view.isHidden = true
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.tableFooterView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Theme.contentBackgroundColor
        return view
    }()
    
    var topConstraint: Constraint? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(GistListTableViewCell.self, forCellReuseIdentifier: String(describing: GistListTableViewCell.self))
       
        addSubview(tableView)
        addSubview(notificationMessageView)
        
        notificationMessageView.snp.makeConstraints { (make) in
            self.topConstraint = make.top.equalTo(self).offset(-35).constraint
            make.height.equalTo(35)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(tableView.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    func showLoading() {
        tableView.backgroundView = LoadingView(frame: .zero)
    }

    func hideLoading() {
        tableView.backgroundView = nil
    }

    func showError(message: String) {
        self.notificationMessageView.isHidden = false
        notificationMessageView.messageLabel.text = message
        tableView.backgroundView = nil
        UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseOut, animations: {
            self.topConstraint?.update(offset: 0)
            self.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 4, options: .curveEaseIn, animations: {
            self.topConstraint?.update(offset: -35)
            self.layoutIfNeeded()
        }, completion: {
            _ in self.notificationMessageView.isHidden = true
        })
    }
}
