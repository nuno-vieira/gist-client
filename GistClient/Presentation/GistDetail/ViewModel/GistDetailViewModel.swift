// Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

struct GistDetailViewModel {
    let gistHtmlUrl: URL
    let title: String

    init(gist: Gist) {
        gistHtmlUrl = gist.htmlUrl
        title = gist.files.first?.name ?? ""
    }
}
