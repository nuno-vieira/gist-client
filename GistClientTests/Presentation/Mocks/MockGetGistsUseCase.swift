// Copyright © 2022 nuno-vieira. All rights reserved.

@testable import GistClient

class MockGetGistsUseCase: GetGistsUseCase {
    var executeCallCount = 0
    var executeResult: Result<[Gist], Error>? = nil

    func execute(completion: @escaping (Result<[Gist], Error>) -> Void) {
        executeCallCount += 1
        if let executeResult = executeResult {
            completion(executeResult)
        }
    }

}
