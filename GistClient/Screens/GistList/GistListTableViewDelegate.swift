//
//  GistListTableViewDelegate.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 19/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit

extension GistListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gist = dataSource.gists[indexPath.row]
        navigator.navigate(to: .detail(gist: gist))
    }
}
