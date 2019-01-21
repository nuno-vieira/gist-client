//
//  User.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 15/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation
import RealmSwift


class User: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var avatarUrl = ""
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
        case name = "login"
    }
}
