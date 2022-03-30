//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

enum AppTheme {

    static func setupNavigationBar() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.navTitle]

        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = Color.navBar
        UINavigationBar.appearance().tintColor = Color.navTitle
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = Color.navBar
            navigationBarAppearance.titleTextAttributes = titleTextAttributes
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        }
    }
}
