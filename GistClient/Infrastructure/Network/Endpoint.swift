//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

struct Endpoint {
    var path: String
    var method: HTTPMethod
    var queryParams: [String: String]
    var body: Data?
}

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
