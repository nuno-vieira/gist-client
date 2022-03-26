// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { String(describing: self) }
}
