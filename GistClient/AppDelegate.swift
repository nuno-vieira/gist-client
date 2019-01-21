//
//  AppDelegate.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 13/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                //if (oldSchemaVersion < 1) { }
        })
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        
        setupNavigationBarAppearance()
        initRootViewController()
        
        return true 
    }

    func initRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let service = GistService(repository: GistRepository())
        let gistListVC = GistListViewController(gistService: service)
        let nav = UINavigationController(rootViewController: gistListVC)
        nav.view.backgroundColor = UIColor.Theme.contentBackgroundColor
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }

    func setupNavigationBarAppearance() {
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.Theme.navBarColor
        UINavigationBar.appearance().tintColor = UIColor.Theme.navTitleColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.Theme.navTitleColor]
    }

}

