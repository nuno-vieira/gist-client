//
//  GetGistsUseCase.swift
//  GistClient
//
//  Created by Nuno Vieira on 21/03/2022.
//  Copyright © 2022 nuno-vieira. All rights reserved.
//

import Foundation

protocol GetGistsUseCase {
    func execute(
        completion: @escaping (Result<[Gist], Error>) -> Void
    )
}

final class DefaultGetGistsUseCase: GetGistsUseCase {
    let gistsRepository: GistsRepositoryAdapter

    init(gistsRepository: GistsRepositoryAdapter) {
        self.gistsRepository = gistsRepository
    }

    func execute(completion: @escaping (Result<[Gist], Error>) -> Void) {
        gistsRepository.getGists(completion: completion)
    }
}
