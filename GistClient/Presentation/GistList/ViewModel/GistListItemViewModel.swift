// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

struct GistListItemViewModel: Equatable {
    let fileNameText: String
    let commentsText: String
    let createdAtText: String
    let ownerNameText: String
    let ownerAvatarUrl: URL?

    private let dateFormatter = DateFormatter.gistItemCreatedAt

    init(gist: Gist) {
        fileNameText = gist.files.first?.name ?? ""
        commentsText = "\(String(gist.numberOfComments)) 💬"
        createdAtText = "\(dateFormatter.string(from: gist.createdAt))"
        ownerNameText = gist.owner.name
        ownerAvatarUrl = gist.owner.avatarUrl
    }
}

fileprivate extension DateFormatter {
    static var gistItemCreatedAt: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}
