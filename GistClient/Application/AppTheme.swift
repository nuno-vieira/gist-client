//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

enum AppTheme {

    static func setupNavigationBar() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.navTitleColor]

        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = Color.navBarColor
        UINavigationBar.appearance().tintColor = Color.navTitleColor
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = Color.navBarColor
            navigationBarAppearance.titleTextAttributes = titleTextAttributes
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        }
    }
}
