//
//  AppDelegate.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 13/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let service = GistService(repository: GistRepository())
        let gistListVC = GistListViewController(gistService: service)
        let nav = UINavigationController(rootViewController: gistListVC)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }

}

