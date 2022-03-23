//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListTableViewDataSource: NSObject, UITableViewDataSource {
    
    var gists: [Gist] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GistListTableViewCell.self)) as? GistListTableViewCell else {
            return UITableViewCell()
        }
        
        let gist = gists[indexPath.row]
        cell.gist = gist
        return cell
    }
    
}
