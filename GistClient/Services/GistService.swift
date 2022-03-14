//
//  GistService.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 14/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation
import Alamofire

class GistService {

    private let baseUrl = "https://api.github.com"

    private var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    let repository: GistRepository
    
    init(repository: GistRepository) {
        self.repository = repository
    }

    func getAllGists(completion: @escaping (Result<[Gist]>) -> ()) {
        let storedGists = repository.getAll()
        completion(.success(storedGists))

        Alamofire
            .request("\(baseUrl)/gists")
            .responseData { [weak self] response in
                
                guard let `self` = self else { return }
                
                switch response.result {
                case .success(let data):
                    do {
                        let gists = try self.jsonDecoder.decode([Gist].self, from: data)
                        self.repository.deleteAll()
                        self.repository.store(gists)
                        completion(.success(gists))
                    } catch {
                        completion(.error(error))
                    }
                    
                case .failure(let error):
                    completion(.error(error))
                }
        }
    }

}
