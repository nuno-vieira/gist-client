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

    func test_gistHtmlUrl() {
        let viewModel = GistDetailViewModel(gist: gist)
        XCTAssertEqual(viewModel.gistHtmlUrl.absoluteString, "url")
    }

    func test_title() {
        let viewModel = GistDetailViewModel(gist: gist)
        XCTAssertEqual(viewModel.title, "hello_world.py")
    }

}
