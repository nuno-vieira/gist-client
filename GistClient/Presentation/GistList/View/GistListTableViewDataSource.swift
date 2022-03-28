//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var gists: [Gist] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuseCell(GistListItemCell.self, for: indexPath)
        let gist = gists[indexPath.row]
        cell.viewModel = GistListItemViewModel(gist: gist)
        return cell
    }
    
}
