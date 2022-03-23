//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

final class GistRepository {
    private let database: GistDatabase
    private let network: GistNetwork

    init(database: GistDatabase, network: GistNetwork) {
        self.database = database
        self.network = network
    }
}

extension GistRepository: GistsRepositoryAdapter {
    func getGists(completion: @escaping (Result<[Gist], Error>) -> Void) {
        database.getGists { result in
            if let gists = try? result.get(), !gists.isEmpty {
                completion(.success(gists))
            }
        }

        network.fetchGists { [weak self] result in
            switch result {
            case .success(let gists):
                self?.database.deleteAll()
                self?.database.save(gists: gists)
                completion(.success(gists))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
