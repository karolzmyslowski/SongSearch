//
//  SongCore+CoreDataProperties.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 14.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//
//

import Foundation
import CoreData


extension SongCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongCore> {
        return NSFetchRequest<SongCore>(entityName: "SongCore")
    }

    @NSManaged public var trackName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var collectionName: String?
    @NSManaged public var artwork: NSData?

}
