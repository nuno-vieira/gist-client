//
//  GistListNavigator.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 19/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

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
            let detailVC = GistDetailViewController(gist: gist)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
