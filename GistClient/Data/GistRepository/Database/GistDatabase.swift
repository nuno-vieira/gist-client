//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

protocol GistDatabase {
    func getGists(completion: @escaping (Result<[Gist], Error>) -> Void)
    func save(gists: [Gist])
    func deleteAll()
}
