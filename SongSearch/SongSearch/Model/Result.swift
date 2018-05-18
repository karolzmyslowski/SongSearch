//
//  Result.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 13.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import Foundation

struct Result: Codable {
    let resultCount : Int
    let results: [Song]
}
