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

    func test_title() {
        let viewModel = DefaultGistDetailViewModel(gist: gist)
        XCTAssertEqual(viewModel.title, "hello_world.py")
    }

    func test_viewDidLoad_thenStateIsLoadGistHtml() {
        let viewModel = DefaultGistDetailViewModel(gist: gist)
        viewModel.viewDidLoad()
        let expectedRequest = URLRequest(url: gist.htmlUrl)
        XCTAssertEqual(viewModel.state.value, .loadGistHtml(request: expectedRequest))
    }

    func test_retry_thenStateIsLoadGistHtml() {
        let viewModel = DefaultGistDetailViewModel(gist: gist)
        viewModel.retry()
        let expectedRequest = URLRequest(url: gist.htmlUrl)
        XCTAssertEqual(viewModel.state.value, .loadGistHtml(request: expectedRequest))
    }

    func test_htmlDidFail_thenStateIsGistHtmlFailed() {
        let viewModel = DefaultGistDetailViewModel(gist: gist)
        viewModel.htmlDidFail()
        XCTAssertEqual(viewModel.state.value, .gistHtmlFailed)
    }

    func test_htmlDidLoad_thenStateIsGistHtmlLoaded() {
        let viewModel = DefaultGistDetailViewModel(gist: gist)
        viewModel.htmlDidLoad()
        XCTAssertEqual(viewModel.state.value, .gistHtmlLoaded)
    }

}
