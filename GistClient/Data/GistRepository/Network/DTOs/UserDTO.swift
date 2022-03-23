//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

struct UserDTO: Codable {
    var id: Int
    var avatarUrl: String
    var login: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
        case login = "login"
    }
}

// MARK: - Data Mapping

extension UserDTO {
    func toDomain() -> User? {
        guard let avatarUrl = URL(string: avatarUrl) else { return nil }
        return User(id: id, avatarUrl: avatarUrl, name: login)
    }
}
