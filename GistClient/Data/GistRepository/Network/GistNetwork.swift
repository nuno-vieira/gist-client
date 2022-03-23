//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

fileprivate extension Endpoint {
    static var gists: Endpoint {
        .init(
            path: "gists",
            method: .get,
            queryParams: [:],
            body: nil
        )
    }
}

protocol GistNetwork {
    func fetchGists(completion: @escaping (Result<[Gist], Error>) -> Void)
}

class DefaultGistNetwork {
    let networkService: NetworkService

    private var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultGistNetwork: GistNetwork {
    func fetchGists(completion: @escaping (Result<[Gist], Error>) -> Void) {
        networkService.request(endpoint: .gists) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let gistsData = data else {
                    completion(.success([]))
                    return
                }
                do {
                    let gistDTOs = try self.jsonDecoder.decode([GistDTO].self, from: gistsData)
                    let gists = gistDTOs.compactMap { $0.toDomain() }
                    completion(.success(gists))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
