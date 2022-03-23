//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation
import RealmSwift

class UserEntity: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var avatarUrl = ""
    @objc dynamic var name = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    static func make(id: Int, avatarUrl: String, name: String) -> UserEntity {
        let entity = UserEntity()
        entity.id = id
        entity.avatarUrl = avatarUrl
        entity.name = name
        return entity
    }
}

// MARK: - Data Mapping

extension UserEntity {
    func toDomain() -> User? {
        guard let url = URL(string: avatarUrl) else { return nil }
        return User(id: id, avatarUrl: url, name: name)
    }
}

extension User {
    func toEntity() -> UserEntity {
        UserEntity.make(id: id, avatarUrl: avatarUrl?.absoluteString ?? "", name: name)
    }
}
