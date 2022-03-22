//
//  DatabaseMigration.swift
//  GistClient
//
//  Created by Nuno Vieira on 22/03/2022.
//  Copyright © 2022 nuno-vieira. All rights reserved.
//

import Foundation

protocol DatabaseMigration {
    func run()
}
