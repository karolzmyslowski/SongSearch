//
//  Song.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 13.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import Foundation

struct Song: Codable {
    let trackName:String
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
}
