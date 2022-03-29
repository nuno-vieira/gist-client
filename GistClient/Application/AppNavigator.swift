// Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

enum AppRoute {
    case gistList
}

class AppNavigator {
    var window: UIWindow
    let appFactory = AppFactory()

    init(window: UIWindow) {
        self.window = window
    }

    func navigate(to route: AppRoute) {
        switch route {
        case .gistList:
            self.window.rootViewController = appFactory.makeRootViewController()
        }
        self.window.makeKeyAndVisible()
    }
}

class AppFactory {
    let device: UIDevice

    init(device: UIDevice = .current) {
        self.device = device
    }

    func makeRootViewController() -> UIViewController {
        let gistListViewModel = makeGistListViewModel()
        let navigationController = UINavigationController()
        let gistListNavigator = DefaultGistListNavigator(navigationController: navigationController)
        let gistListViewController = GistListViewController(viewModel: gistListViewModel, navigator: gistListNavigator)
        navigationController.viewControllers = [gistListViewController]
        return navigationController
    }

    private func makeGistListViewModel() -> GistListViewModel {
        let networkConfig = NetworkConfig(baseUrl: URL(string: "https://api.github.com")!)
        let networkService = URLSessionNetworkService(networkConfig: networkConfig)
        let gistsNetwork = DefaultGistNetwork(networkService: networkService)
        let gistsDatabase = RealmGistDatabase()
        let gistsRepository = GistRepository(database: gistsDatabase, network: gistsNetwork)
        let getGistsUseCase = DefaultGetGistsUseCase(gistsRepository: gistsRepository)
        return DefaultGistListViewModel(getGistsUseCase: getGistsUseCase)
    }
}
