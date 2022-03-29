//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

struct Gist: Equatable {
    var id: String
    var createdAt: Date
    var numberOfComments: Int
    var owner: User
    var htmlUrl: URL
    var files: [File]
}
