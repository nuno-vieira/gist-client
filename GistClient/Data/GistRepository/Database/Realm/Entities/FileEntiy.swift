//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation
import RealmSwift

class FileEntity: Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var rawUrl: String = ""

    static func make(name: String, rawUrl: String) -> FileEntity {
        let entity = FileEntity()
        entity.name = name
        entity.rawUrl = rawUrl
        return entity
    }
}

// MARK: - Data Mapping

extension FileEntity {
    func toDomain() -> File? {
        guard let url = URL(string: rawUrl) else { return nil }
        return File(name: name, rawUrl: url)
    }
}

extension File {
    func toEntity() -> FileEntity {
        FileEntity.make(name: name, rawUrl: rawUrl.absoluteString)
    }
}
