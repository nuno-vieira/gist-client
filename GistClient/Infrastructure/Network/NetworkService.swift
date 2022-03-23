//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

enum NetworkServiceError: Error {
    case invalidUrl
    case requestFailed(Error)
}

protocol NetworkService {
    func request(endpoint: Endpoint, completion: @escaping (Result<Data?, NetworkServiceError>) -> Void)
}

struct NetworkConfig {
    let baseUrl: URL
}

class URLSessionNetworkService: NetworkService {
    let urlSession: URLSession
    let networkConfig: NetworkConfig

    init(urlSession: URLSession = .shared, networkConfig: NetworkConfig) {
        self.urlSession = urlSession
        self.networkConfig = networkConfig
    }

    func request(endpoint: Endpoint, completion: @escaping (Result<Data?, NetworkServiceError>) -> Void) {
        var url = networkConfig.baseUrl
        url.appendPathComponent(endpoint.path)

        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = endpoint.queryParams.map { parameter in
            URLQueryItem(name: parameter.key, value: parameter.value)
        }

        guard let finalUrl = urlComponents?.url else {
            completion(.failure(NetworkServiceError.invalidUrl))
            return
        }

        var urlRequest = URLRequest(url: finalUrl)
        urlRequest.httpBody = endpoint.body

        urlSession.dataTask(with: urlRequest) { data, _, error in
            let result: Result<Data?, NetworkServiceError>
            defer {
                completion(result)
            }

            if let error = error {
                result = .failure(NetworkServiceError.requestFailed(error))
                return
            }

            result = .success(data)
        }.resume()
    }
}
