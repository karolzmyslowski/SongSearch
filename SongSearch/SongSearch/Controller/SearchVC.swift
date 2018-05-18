//
//  SearchVC.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 13.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var songs: [Song] = []
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    @IBOutlet weak var constraintTopView: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {

        let searchString = searchTextField.text
        if searchString != nil && searchString != "" {
            SongService.shared.getSong(searchString: searchString!) { (responce, error) in
                if let resp = responce {
                    self.songs = resp.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell {
            let song = songs[indexPath.row]
            cell.delegate = self
            cell.titleLbn.text = song.trackName
            cell.artistLbn.text = song.artistName
            cell.collectionLbn.text = song.collectionName
            
            SongService.shared.getImageFromWeb(song.artworkUrl100) { (image, error) in
                if let error = error {
                    print(error)
                } else {
                    if let image = image {
                        cell.imageSong.image = image
                        SearchVC.imageCache.setObject(image, forKey: song.artworkUrl100 as NSString)
                    }
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
}

extension SearchVC: UITableViewDelegate {}

extension SearchVC: UITextFieldDelegate{
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case searchTextField:
            searchTextField.resignFirstResponder()
            return true
        default:
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case searchTextField:
            UIView.animate(withDuration: 1, animations: {
                self.constraintTopView.constant = -165
                self.view.layoutIfNeeded()
            })
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case searchTextField:
            UIView.animate(withDuration: 0.2, animations: {
                self.constraintTopView.constant = 0
                self.view.layoutIfNeeded()
            })
        default: break
        }
    }
}

extension SearchVC: SearchCellDelegate {
    func didTapSave(_ sender: SearchTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else {
            return
        }
        let song = songs[indexPath.row]
        if let image = sender.imageSong.image {
            CoreDataManager.storeObj(song: song, image: image)
        }
        let alertTitle = "Added"
        let message = song.trackName
        AlertService.alert(in: self, title: alertTitle, message: message)
    }
}
