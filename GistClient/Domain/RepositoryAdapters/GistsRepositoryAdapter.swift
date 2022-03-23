//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

protocol GistsRepositoryAdapter {
    func getGists(completion: @escaping (Result<[Gist], Error>) -> Void)
}
