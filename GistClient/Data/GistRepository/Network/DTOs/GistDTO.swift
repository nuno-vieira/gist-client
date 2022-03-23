//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

struct GistDTO: Codable {
    var id: String
    var createdAt: Date
    var numberOfComments: Int
    var owner: UserDTO
    var htmlUrl: String
    var files: [String: FileDTO] = [:]

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case numberOfComments = "comments"
        case owner = "owner"
        case files
        case htmlUrl = "html_url"
    }
}

// MARK: - Data Mapping

extension GistDTO {
    func toDomain() -> Gist? {
        guard let owner = self.owner.toDomain() else { return nil }
        guard let htmlUrl = URL(string: self.htmlUrl) else { return nil }
        let files = files
            .map(\.value)
            .compactMap { $0.toDomain() }

        return Gist(
            id: id,
            createdAt: createdAt,
            numberOfComments: numberOfComments,
            owner: owner,
            htmlUrl: htmlUrl,
            files: files
        )
    }
}
