//  Created by Vieira, Nuno (Developer) on 21/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation
import RealmSwift

class GistRepository {
    var realm: Realm = try! Realm()

    func getAll() -> [Gist] {
        let gists = realm.objects(Gist.self)
        return Array(gists)
    }

    func store(_ gists: [Gist]) {
        try! realm.write {
            realm.add(gists, update: .all)
        }
    }

    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
