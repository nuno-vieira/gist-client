//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

extension AppTheme {
    enum Color {
        static let navTitleColor = UIColor.label
        static let borderColor = UIColor(hex: 0xd1d5da)
        static let successColor = UIColor.green
        static let warningColor = UIColor.yellow
        static let errorColor = UIColor(hex: 0xcb2431)
        static let textColor = UIColor(hex: 0x768390)
        static let boldText = UIColor.label
        static let navBarColor = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .light:
                    return UIColor(hex: 0xf8f8fa)
                case .dark:
                    return UIColor(hex: 0x2d333b)
                default:
                    return UIColor(hex: 0xf8f8fa)
            }
        }
        static let contentBackgroundColor = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .light:
                    return UIColor(hex: 0xf6f8fa)
                case .dark:
                    return UIColor(hex: 0x22272e)
                default:
                    return UIColor(hex: 0xf6f8fa)
            }
        }
    }
}
