//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

protocol GistListNavigator {
    func navigate(to route: GistListRoute)
}

class DefaultGistListNavigator: GistListNavigator {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func navigate(to route: GistListRoute) {
        switch route {
        case let .detail(gist):
            let viewModel = GistDetailViewModel(gist: gist)
            let detailVC = GistDetailViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
