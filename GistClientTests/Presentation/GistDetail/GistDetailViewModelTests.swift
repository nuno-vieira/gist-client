// Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest
@testable import GistClient

class GistDetailViewModelTests: XCTestCase {

    let gist = Gist(
        id: "test",
        createdAt: .now,
        numberOfComments: 3,
        owner: User(id: 1, avatarUrl: nil, name: "test"),
        htmlUrl: URL(string: "url")!,
        files: [File(name: "hello_world.py", rawUrl: URL(string: "raw")!)]
    )

    var viewModel: GistDetailViewModel {
        GistDetailViewModel(gist: gist)
    }

    func test_gistHtmlUrl() {
        XCTAssertEqual(viewModel.gistHtmlUrl.absoluteString, "url")
    }

    func test_title() {
        XCTAssertEqual(viewModel.title, "hello_world.py")
    }

}
