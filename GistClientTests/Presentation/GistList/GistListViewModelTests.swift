// Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest
@testable import GistClient

class GistListViewModelTests: XCTestCase {

    let gists: [Gist] = [
        Gist(
            id: "1",
            createdAt: .distantFuture,
            numberOfComments: 2,
            owner: .init(id: 1, avatarUrl: nil, name: "test"),
            htmlUrl: URL(string: "test")!,
            files: []
        ),
        Gist(
            id: "2",
            createdAt: .distantFuture,
            numberOfComments: 3,
            owner: .init(id: 2, avatarUrl: nil, name: "test2"),
            htmlUrl: URL(string: "test2")!,
            files: []
        )
    ]

    var viewModel: GistListViewModel!
    var mockUseCase: MockGetGistsUseCase!

    override func setUpWithError() throws {
        // Given
        mockUseCase = MockGetGistsUseCase()
        viewModel = DefaultGistListViewModel(getGistsUseCase: mockUseCase)
    }

    override func tearDownWithError() throws {
        mockUseCase = nil
        viewModel = nil
    }

    func test_title() {
        XCTAssertEqual(viewModel.title, "Gists")
    }

    func test_viewDidLoad_whenGistsLoading_thenStateIsLoading_thenRouteIsNil() {
        viewModel.viewDidLoad()

        XCTAssertEqual(viewModel.state.value, .loading)
    }

    func test_viewDidLoad_whenGistsFetched_thenStateIsPopulated() {
        // When
        mockUseCase.executeResult = .success(gists)

        // Then
        viewModel.viewDidLoad()
        let itemViewModels = gists.map(GistListItemViewModel.init)
        XCTAssertEqual(viewModel.state.value, .populated(itemViewModels))
    }

    func test_viewDidLoad_whenGistsFailToLoad_thenStateIsError() {
        // When
        struct MockError: Error {}
        mockUseCase.executeResult = .failure(MockError())

        // Then
        viewModel.viewDidLoad()
        XCTAssertEqual(viewModel.state.value, .error(message: MockError().localizedDescription))
    }

    func test_selectGist_whenGistsFetched_thenRouteIsGistDetail() {
        // When
        mockUseCase.executeResult = .success(gists)
        viewModel.viewDidLoad()

        // Then
        viewModel.selectGist(at: 1)
        XCTAssertEqual(viewModel.route.value, .detail(gist: gists[1]))
    }

    func test_retry_thenRefetchGists() {
        viewModel.retry()
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
    }
    
}
