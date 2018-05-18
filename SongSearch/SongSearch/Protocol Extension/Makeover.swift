//
//  Makeover.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 17.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

protocol Makeover {
    func makeover(view: UIView)
}

extension Makeover {
    func makeover(view: UIView){
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.shadowOpacity = 0.8
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor(red: 86/255, green: 146/255, blue: 183/255, alpha: 0.6).cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.cornerRadius = 5
    }

}
