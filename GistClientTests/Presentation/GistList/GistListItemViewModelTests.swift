// Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest
@testable import GistClient

class GistListItemViewModelTests: XCTestCase {

    let gist = Gist(
        id: "test",
        createdAt: Date(timeIntervalSince1970: 1648503743),
        numberOfComments: 3,
        owner: User(id: 1, avatarUrl: URL(string: "avatar"), name: "test"),
        htmlUrl: URL(string: "url")!,
        files: [File(name: "hello_world.py", rawUrl: URL(string: "raw")!)]
    )

    var viewModel: GistListItemViewModel {
        GistListItemViewModel(gist: gist)
    }

    func test_fileNameText() {
        XCTAssertEqual(viewModel.fileNameText, "hello_world.py")
    }

    func test_commentsText() {
        XCTAssertEqual(viewModel.commentsText, "3 💬")
    }

    func test_createdAtText() {
        XCTAssertEqual(viewModel.createdAtText, "10:42 PM")
    }

    func test_ownerNameText() {
        XCTAssertEqual(viewModel.ownerNameText, "test")
    }

    func test_ownerAvatarUrl() {
        XCTAssertEqual(viewModel.ownerAvatarUrl?.absoluteString, "avatar")
    }
}
