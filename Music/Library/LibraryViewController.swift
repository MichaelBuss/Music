//
//  LibraryTableViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 15/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        for _ in 1...100 {songs.append(song)} // Loads songs[] with 100 of the same fake song.
    }

    // MARK: - Outlets
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var libraryTableView: UITableView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    private let libraryCell = LibraryTableViewCell()
    
    private let song: (title: String, artist: String, album: String, coverArt: UIImage) = ("Under Your Spell", "Desire" , "Drive (Original Motion Picture Soundtrack)", #imageLiteral(resourceName: "CoverDrive"))
    
    private lazy var songs = [song]
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath)
        if let libraryCell = cell as? LibraryTableViewCell {
            switch sortSegmentedControl.selectedSegmentIndex{ // Not a good place for this!
                case 0: print("Artists")
                case 1: print("Albums")
                case 2: print("Songs")
            default: break
            }
            
            libraryCell.label.text = songs[indexPath.item].artist
            libraryCell.imageArt.image = songs[indexPath.item].coverArt
        }
        return cell
    }
    
    // MARK: - Actions
    @IBAction func sortSegmentedControlDidChange(_ sender: UISegmentedControl) {
        updateTable()
        animatePlayerHeight(to: 400, withDuration: 0.5) // TODO: - Totally wierd place to put this, but I'm simply testing animation for the first time and didn't bother
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
    }
    
    // MARK: - Mathods
    
    private func updateTable() {
        print("Updating table")
        libraryTableView.reloadData()
    }
    
    private func animatePlayerHeight(to height: Int, withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            self.playerViewHeight.constant = CGFloat(height)
            self.view.layoutIfNeeded()
        }
    }

}
