//  Copyright © 2022 nuno-vieira. All rights reserved.

import Foundation

protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}
