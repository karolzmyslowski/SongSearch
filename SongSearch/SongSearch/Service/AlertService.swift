//
//  AlertService.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 18.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class AlertService {
    
    private init() {}
    
    static func alert(in vc: UIViewController, title: String, message: String) {
        let aletr = UIAlertController(title: title, message: message, preferredStyle: .alert)
        aletr.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(aletr, animated: true, completion: nil)
    }
}
