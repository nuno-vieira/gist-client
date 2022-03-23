//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation
@testable import GistClient

class MockGistsRepository: GistsRepositoryAdapter {
    var getGistsResult: Result<[Gist], Error> = .success([])
    var getGistsCallCount = 0

    func getGists(completion: @escaping (Result<[Gist], Error>) -> Void) {
        getGistsCallCount += 1
        completion(getGistsResult)
    }
}
