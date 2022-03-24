//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dbMigration: DatabaseMigration = RealmDatabaseMigration()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dbMigration.run()
        AppTheme.setupNavigationBar()
        initRootViewController()
        return true 
    }

    func initRootViewController() {
        let networkConfig = NetworkConfig(baseUrl: URL(string: "https://api.github.com")!)
        let networkService = URLSessionNetworkService(networkConfig: networkConfig)
        let gistsNetwork = DefaultGistNetwork(networkService: networkService)
        let gistsDatabase = RealmGistDatabase()
        let gistsRepository = GistRepository(database: gistsDatabase, network: gistsNetwork)
        let getGistsUseCase = DefaultGetGistsUseCase(gistsRepository: gistsRepository)
        let gistListViewController = GistListViewController(getGistsUseCase: getGistsUseCase)
        let navigationController = UINavigationController(rootViewController: gistListViewController)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

}

