//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListNavigator: Navigator {
    enum Destination {
        case detail(gist: Gist)
    }

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func navigate(to destination: Destination) {
        switch destination {
        case let .detail(gist):
            let viewModel = GistDetailViewModel(gist: gist)
            let detailVC = GistDetailViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
