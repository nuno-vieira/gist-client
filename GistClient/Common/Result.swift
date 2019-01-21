//
//  Result.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 14/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

