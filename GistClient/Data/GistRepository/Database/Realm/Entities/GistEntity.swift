//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation
import RealmSwift

class GistEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var createdAt: Date?
    @objc dynamic var numberOfComments = 0
    @objc dynamic var owner: UserEntity?
    @objc dynamic var htmlUrl: String = ""
    let files = List<FileEntity>()

    override static func primaryKey() -> String? {
        return "id"
    }

    static func make(
        id: String,
        createdAt: Date,
        numberOfComments: Int,
        owner: UserEntity,
        htmlUrl: String,
        files: [FileEntity]
    ) -> GistEntity {
        let entity = GistEntity()
        entity.id = id
        entity.createdAt = createdAt
        entity.numberOfComments = numberOfComments
        entity.owner = owner
        entity.htmlUrl = htmlUrl
        entity.files.append(objectsIn: files)
        return entity
    }
}

// MARK: - Data Mapping

extension GistEntity {
    func toDomain() -> Gist? {
        guard let createdAt = self.createdAt else { return nil }
        guard let owner = self.owner?.toDomain() else { return nil }
        guard let htmlUrl = URL(string: self.htmlUrl) else { return nil }

        return Gist(
            id: id,
            createdAt: createdAt,
            numberOfComments: numberOfComments,
            owner: owner,
            htmlUrl: htmlUrl,
            files: files.compactMap { $0.toDomain() }
        )
    }
}

extension Gist {
    func toEntity() -> GistEntity {
        GistEntity.make(
            id: id,
            createdAt: createdAt,
            numberOfComments: numberOfComments,
            owner: owner.toEntity(),
            htmlUrl: htmlUrl.absoluteString,
            files: files.map { $0.toEntity() }
        )
    }
}
