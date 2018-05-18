//
//  PopupVC.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 17.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

protocol PopupVCDelegate {
    func index(index: Int)
}

class PopupVC: UIViewController {
    
    var delegate: PopupVCDelegate?
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonTapped(_ sender: SearchButton) {
        let index = sender.tag
        delegate?.index(index: index)
        dismiss(animated: true, completion: nil)
    }
}
