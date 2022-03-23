// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation
import RealmSwift

final class RealmGistDatabase: GistDatabase {
    let queue = DispatchQueue(label: "com.gist-client.gist-database")

    func getGists(completion: @escaping (Result<[Gist], Error>) -> Void) {
        queue.async {
            do {
                let realm = try Realm()
                let gistEntities = realm.objects(GistEntity.self)
                let gistDTOs = gistEntities.compactMap { $0.toDomain() }
                completion(.success(Array(gistDTOs)))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func save(gists: [Gist]) {
        queue.async {
            let realm = try? Realm()
            try? realm?.write {
                realm?.add(gists.map { $0.toEntity() }, update: .all)
            }
        }
    }

    func deleteAll() {
        queue.async {
            let realm = try? Realm()
            try? realm?.write {
                realm?.deleteAll()
            }
        }
    }
}
