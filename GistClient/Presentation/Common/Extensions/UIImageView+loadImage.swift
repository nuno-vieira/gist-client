//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: URL?) {
        kf.setImage(with: url)
    }
}
