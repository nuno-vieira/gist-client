//  Copyright © 2022 nuno-vieira. All rights reserved.

import XCTest
@testable import GistClient

class DefaultGetGistsUseCaseTests: XCTestCase {

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
            numberOfComments: 2,
            owner: .init(id: 1, avatarUrl: nil, name: "test"),
            htmlUrl: URL(string: "test")!,
            files: []
        )
    ]

    func test_execute_whenGistsFetchSucceeds_thenResultIsSuccess() {
        // Given
        let exp = expectation(description: "result is success")
        let mockedGistsRepository = MockGistsRepository()
        let getGistsUseCase = DefaultGetGistsUseCase(gistsRepository: mockedGistsRepository)

        // When
        mockedGistsRepository.getGistsResult = .success(gists)

        // Then
        var actualGists = [Gist]()
        getGistsUseCase.execute { result in
            if case .success(let gists) = result {
                actualGists = gists
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 0.5)
        XCTAssertEqual(actualGists.map(\.id), gists.map(\.id))
    }

    func test_execute_whenGistsFetchFails_thenResultIsFailure() {
        // Given
        let exp = expectation(description: "result is failure")
        let mockedGistsRepository = MockGistsRepository()
        let getGistsUseCase = DefaultGetGistsUseCase(gistsRepository: mockedGistsRepository)

        // When
        struct MockError: Error {}
        mockedGistsRepository.getGistsResult = .failure(MockError())

        // Then
        var actualError: Error?
        getGistsUseCase.execute { result in
            if case .failure(let error) = result {
                actualError = error
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 0.5)
        XCTAssertTrue(actualError is MockError)
    }

}
