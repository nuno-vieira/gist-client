//
//  Gist.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 14/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation
import RealmSwift


class Gist: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var createdAt: Date?
    @objc dynamic var numberOfComments = 0
    @objc dynamic var desc: String?
    @objc dynamic var owner: User?
    @objc dynamic var url: String = ""
    var filename: String {
        get {
            if _filename.isEmpty, let file = files.first?.value {
                update(filename: file.name)
            }
            return _filename
        }
        set {
            update(filename: newValue)
        }
    }
    
    @objc dynamic private var _filename: String = ""
    private var files: [String: File] = [:]
    
    override static func primaryKey() -> String? {
        return "id"
    }

    override static func ignoredProperties() -> [String] {
        return ["files", "filename"]
    }

    private func update(filename: String) {
        let realm = try! Realm()
        try! realm.write {
            _filename = filename
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case numberOfComments = "comments"
        case desc = "description"
        case owner = "owner"
        case files
        case url = "html_url"
    }
}
