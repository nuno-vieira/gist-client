// Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init(dynamicProvider: { traitCollection -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return light
            case .dark:
                return dark
            default:
                return light
            }
        })
    }
}
