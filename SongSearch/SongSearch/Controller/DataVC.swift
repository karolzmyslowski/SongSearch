//
//  DataVC.swift
//  SongSearch
//
//  Created by Karol Zmyslowski on 13.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class DataVC: UIViewController, PopupVCDelegate {

    var songs: [SongCore] = []
    var scopeIndex: Int?
    
    @IBOutlet weak var constraintTopView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.loadSaveData { (songCore, error) in
            
            if let songCore = songCore{
              self.songs = songCore
            }
            self.tableView.reloadData()
        }
    }

    @IBAction func sortByButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "popup", sender: nil)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popup" {
            if let vc = segue.destination as? PopupVC {
                vc.delegate = self
            }
        }
    }
    
    func index(index: Int) {
        scopeIndex = index
    }
}

extension DataVC: UITableViewDelegate {}

extension DataVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataTableViewCell {
            let song = songs[indexPath.row]
            cell.delegate = self
            cell.titleLbn.text = song.trackName
            cell.artistLbn.text = song.artistName
            cell.collectionLbn.text = song.collectionName
            if let data = song.artwork as Data? {
                cell.artworImg.image = UIImage(data: data)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
}

extension DataVC: DataCellDelegate{
    
    func didTapDelete(_ sender: DataTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else {
            return
        }
        let songItem = songs[indexPath.row]
        let alertTitle = "Removed"
        let message = songItem.trackName
        AlertService.alert(in: self, title: alertTitle, message: message!)
        CoreDataManager.deleteObj(song: songItem)
        CoreDataManager.loadSaveData { (songCore, error) in
            if let songCore = songCore{
                self.songs = songCore
            }
            self.tableView.reloadData()
        }
    }
}

extension DataVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            songs = CoreDataManager.fetchObj()
            tableView.reloadData()
            return
        }
        songs = CoreDataManager.fetchObj(selectedScopeIdx: scopeIndex, targetText:searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        switch searchBar {
        case searchBar:
            UIView.animate(withDuration: 1, animations: {
                self.constraintTopView.constant = -165
                self.view.layoutIfNeeded()
            })
        default:
            break
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        switch searchBar {
        case searchBar:
            UIView.animate(withDuration: 0.2, animations: {
                self.constraintTopView.constant = 0
                self.view.layoutIfNeeded()
            })
        default:
            break
        }
    }
}
