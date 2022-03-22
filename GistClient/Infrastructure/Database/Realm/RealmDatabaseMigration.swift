//
//  RealmDatabaseMigration.swift
//  GistClient
//
//  Created by Nuno Vieira on 22/03/2022.
//  Copyright © 2022 nuno-vieira. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabaseMigration: DatabaseMigration {
    func run() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                //if (oldSchemaVersion < 1) { }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
    }
}
