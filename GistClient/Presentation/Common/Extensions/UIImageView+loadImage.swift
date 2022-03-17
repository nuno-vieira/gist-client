//
//  UIImageView+loadImage.swift
//  GistClient
//
//  Created by Nuno Vieira on 16/03/2022.
//  Copyright © 2022 nuno-vieira. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: URL?) {
        kf.setImage(with: url)
    }
}
