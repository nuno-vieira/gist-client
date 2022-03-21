//
//  Gist.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 14/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation

struct Gist {
    var id: String
    var createdAt: Date
    var numberOfComments: Int
    var owner: User
    var htmlUrl: URL
    var files: [File]
}
