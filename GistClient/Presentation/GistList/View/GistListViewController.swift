//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListViewController: UIViewController {
    let dataSource = GistListTableViewDataSource()

    let viewModel: GistListViewModel
    let navigator: GistListNavigator

    init(viewModel: GistListViewModel, navigator: GistListNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var gistListView = GistListView()

    override func loadView() {
        view = gistListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        gistListView.configure(dataSource: dataSource)
        gistListView.configure(delegate: self)
        gistListView.onErrorRetry = { [weak self] in
            self?.viewModel.retry()
        }

        viewModel.viewDidLoad()
        viewModel.state.observe(self) { [weak self] state in
            self?.onStateChanged(state)
        }
        viewModel.route.observe(self) { [weak self] route in
            route.map { self?.onRouteChanged($0) }
        }
    }

    private func onStateChanged(_ state: GistListViewState) {
        switch state {
        case .loading:
            gistListView.showLoading()
        case .populated(let items):
            dataSource.items = items
            gistListView.hideLoading()
            gistListView.reloadData()
        case .error:
            gistListView.showError()
        }
    }

    private func onRouteChanged(_ route: GistListRoute) {
        navigator.navigate(to: route)
    }

}

