//  Copyright © 2022 nuno-vieira. All rights reserved.

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
    
    let getGistsUseCase: GetGistsUseCase
    init(getGistsUseCase: GetGistsUseCase) {
        self.getGistsUseCase = getGistsUseCase
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
        getGistsUseCase.execute { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let gists):
                    self?.state = .populated(gists)
                case .failure(let error):
                    self?.state = .error(message: error.localizedDescription)
                }
            }
        }
    }

}

