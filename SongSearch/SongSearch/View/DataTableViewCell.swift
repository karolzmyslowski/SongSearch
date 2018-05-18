//
//  DataTableViewCell.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 14.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

protocol DataCellDelegate {
    func didTapDelete(_ sender: DataTableViewCell)
}

class DataTableViewCell: UITableViewCell {

    var delegate: DataCellDelegate?

    @IBOutlet weak var titleLbn: UILabel!
    @IBOutlet weak var artistLbn: UILabel!
    @IBOutlet weak var collectionLbn: UILabel!
    @IBOutlet weak var artworImg: UIImageView!
    
    @IBAction func daleteButtonTapped(_ sender: UIButton) {
        delegate?.didTapDelete(self)
    }
}
