//
//  SearchView.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 15.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class SearchView: UIView, Makeover {

    override func layoutSubviews() {
        super.layoutSubviews()
        makeover(view: self)
    }
}
