//
//  SongService.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 13.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class SongService {
    
    private init() {}
    
    static let shared = SongService()
    
    func getSong(searchString: String, completion: @escaping (Result?, Error?) -> ()) {

        let tempString = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        let urlString = "https://itunes.apple.com/search?term=\(String(describing: tempString!))&entity=song"
        
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
        guard let tempData = data else {
            return completion(nil, error)
            }
        do {
            let song = try JSONDecoder().decode(Result.self, from: tempData)
            completion(song, nil)
        } catch {
            completion(nil, error)
            }
        }.resume()
    }
    
    func getImageFromWeb(_ urlString: String, completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return completion(nil, error)
            }
            guard response != nil else {
                return completion(nil, error)
            }
            guard let data = data else {
                return completion(nil, error)
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data), nil)
            }
        }.resume()
    }
}
