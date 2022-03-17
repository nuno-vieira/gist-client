//
//  Navigator.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 19/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation

protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}
