// Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

extension UITableView {
    func reuseCell<CellType: UITableViewCell & ReuseIdentifiable>(
        _ cellType: CellType.Type, for indexPath: IndexPath
    ) -> CellType {
        let identifier = cellType.reuseIdentifier
        guard let cell = dequeueReusableCell(
            withIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? CellType else {
            assertionFailure("Could not dequeue cell with identifier: \(identifier)")
            return CellType.init()
        }
        return cell
    }
}
