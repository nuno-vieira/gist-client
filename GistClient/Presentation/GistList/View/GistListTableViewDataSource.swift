//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var items: [GistListItemViewModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuseCell(GistListItemCell.self, for: indexPath)
        cell.viewModel = items[indexPath.row]
        return cell
    }
    
}
