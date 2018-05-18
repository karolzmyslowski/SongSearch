//
//  CoreDataManager.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 17.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func storeObj(song: Song, image: UIImage) {
        let context = getContext()
        
        let songToSave = SongCore(context: context)
        songToSave.artistName = song.artistName
        songToSave.trackName = song.trackName
        songToSave.collectionName = song.collectionName
        songToSave.artwork = UIImagePNGRepresentation(image) as NSData?
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func loadSaveData(completion: @escaping ([SongCore]?, Error?) -> ())  {
        let context = getContext()
        do {
            let songs: [SongCore] = try context.fetch(SongCore.fetchRequest())
            completion(songs, nil)
        } catch let error as NSError {
            completion(nil, error)
        }
    }
    
    class func fetchObj(selectedScopeIdx:Int?=nil, targetText:String?=nil) -> [SongCore]{
        let context = getContext()
        
        var array = [SongCore]()
        let fetchRequest:NSFetchRequest<SongCore> = SongCore.fetchRequest()
        if selectedScopeIdx != nil && targetText != nil{
            
            var filterKeyword = ""
            switch selectedScopeIdx! {
            case 1:
                filterKeyword = "artistName"
            case 2:
                filterKeyword = "collectionName"
            default:
                filterKeyword = "trackName"
            }
            let predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            fetchRequest.predicate = predicate
        }
        do {
            let fetchResult = try context.fetch(fetchRequest)
            for item in fetchResult {
                array.append(item)
            }
        } catch {
            print(error.localizedDescription)
        }
        return array
    }
    
    class func deleteObj(song: SongCore) {
        let context = getContext()
        context.delete(song)
        do {
            try context.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
        }
    }
}
