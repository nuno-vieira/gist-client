//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

struct FileDTO: Codable {
    var name: String
    var rawUrl: String

    enum CodingKeys: String, CodingKey {
        case name = "filename"
        case rawUrl = "raw_url"
    }
}

// MARK: - Data Mapping

extension FileDTO {
    func toDomain() -> File? {
        guard let rawUrl = URL(string: rawUrl) else { return nil }
        return File(name: name, rawUrl: rawUrl)
    }
}
