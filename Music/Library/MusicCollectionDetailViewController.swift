//
//  MusicCollectionDetailViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 11/06/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicCollectionDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    let albumSongTableViewCell = AlbumSongTableViewCell()
    let albumHeaderTableViewCell = AlbumHeaderTableViewCell()
    var query = MPMediaQuery()
    let musicPlayer = MusicPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfSongs = query.items?.count {
            return numberOfSongs
        } else {
            print("Could not extract query items count, returning 1 instead")
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumSongCell", for: indexPath) as! AlbumSongTableViewCell
        
        if let songTitle = query.items?[indexPath.row].title {
            cell.setupCell(withSongNumber: String(indexPath.row+1), withText: songTitle)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let albumHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AlbumHeaderCell") as! AlbumHeaderTableViewCell
        
        if let albumName = query.items?[section].title {
             albumHeaderCell.setupCell(withImage: #imageLiteral(resourceName: "CoverBuildARocketBoys"), withText: albumName)
        }

       
        return albumHeaderCell
    }

}
