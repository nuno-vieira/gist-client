//
//  File.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 18/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import Foundation
import RealmSwift

class File: Object, Codable {
    var name: String = ""
    var type: String = ""
    var language: String?
    var rawUrl: String = ""

    enum CodingKeys: String, CodingKey {
        case name = "filename"
        case type
        case language
        case rawUrl = "raw_url"
    }
}
