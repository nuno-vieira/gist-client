//
//  ViewController.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 13/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit

class GistListViewController: UIViewController {
    
    let gistListView = GistListView(frame: .zero)
    let dataSource = GistListTableViewDataSource()
    
    lazy var navigator: GistListNavigator = {
        return GistListNavigator(navigationController: self.navigationController)
    }()
    
    enum State {
        case loading
        case populated([Gist])
        case error(message: String)
    }
    
    let service: GistService
    init(gistService: GistService) {
        self.service = gistService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                gistListView.showLoading()
            case let .populated(gists):
                gistListView.hideLoading()
                dataSource.gists = gists
                gistListView.tableView.reloadData()
            case let .error(message):
                gistListView.showError(message: message)
            }
        }
    }

    override func loadView() {
        view = gistListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gists"
        gistListView.tableView.dataSource = dataSource
        gistListView.tableView.delegate = self
        
        state = .loading
        service.getAllGists { [weak self] (result) in
            switch result {
            case .success(let gists):
                self?.state = .populated(gists)
            case .error(let error):
                self?.state = .error(message: error.localizedDescription)
            }
        }
    }

}

