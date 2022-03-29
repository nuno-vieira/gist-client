//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var dbMigration: DatabaseMigration = RealmDatabaseMigration()
    var appNavigator: AppNavigator = AppNavigator(window: UIWindow(frame: UIScreen.main.bounds))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppTheme.setupNavigationBar()
        dbMigration.run()
        appNavigator.navigate(to: .gistList)
        return true 
    }
}
