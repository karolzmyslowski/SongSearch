//
//  SearchTableViewCell.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 13.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

protocol SearchCellDelegate {
    func didTapSave(_ sender: SearchTableViewCell)
}

class SearchTableViewCell: UITableViewCell {

    var delegate: SearchCellDelegate?
    
    @IBOutlet weak var titleLbn: UILabel!
    @IBOutlet weak var artistLbn: UILabel!
    @IBOutlet weak var collectionLbn: UILabel!
    @IBOutlet weak var imageSong: UIImageView!
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        delegate?.didTapSave(self)
    }
}
