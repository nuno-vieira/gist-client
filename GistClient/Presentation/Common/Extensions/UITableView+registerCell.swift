// Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

extension UITableView {
    func registerCell<CellType: UITableViewCell & ReuseIdentifiable>(_ cellType: CellType.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}
