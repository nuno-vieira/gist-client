//
//  GistsRepositoryAdapter.swift
//  GistClient
//
//  Created by Nuno Vieira on 21/03/2022.
//  Copyright © 2022 nuno-vieira. All rights reserved.
//

import Foundation

protocol GistsRepositoryAdapter {
    func getGists(completion: @escaping (Result<[Gist], Error>) -> Void)
}
