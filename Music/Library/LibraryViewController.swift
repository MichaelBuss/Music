//
//  LibraryTableViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 15/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playerContainerView: UIView!
    let musicLibrary = MusicLibrary()
    
    private var playerObserver: NSObjectProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View will appear")
        playerObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name("ExpandPlayer"),
            object: nil,
            queue: OperationQueue.main,
            using: {notification in
                print("Recieved Notification with \(notification.name)")
                if let height = notification.userInfo!["targetHeight"] as? Int {
                    self.animatePlayerHeight(to: height, withDuration: 2)
                }
            }
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View did disappear")
        if let observer = self.playerObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
    }

    // MARK: - Outlets
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var libraryTableView: UITableView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    
    // MARK: - Variables
    private let libraryCell = LibraryTableViewCell()
    

    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicLibrary.songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath)
        if let libraryCell = cell as? LibraryTableViewCell {
//            switch sortSegmentedControl.selectedSegmentIndex{ // Not a good place for this!
//                case 0: print("Artists")
//                case 1: print("Albums")
//                case 2: print("Songs")
//            default: break
//            }
            
            libraryCell.label.text = musicLibrary.songs[indexPath.item].artist
            libraryCell.imageArt.image = musicLibrary.songs[indexPath.item].coverArt
        }
        return cell
    }
    
    // MARK: - Actions
    @IBAction func sortSegmentedControlDidChange(_ sender: UISegmentedControl) {
        updateTable()
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
    }
    
    // MARK: - Mathods
    
    private func updateTable() {
        print("Updating table")
        libraryTableView.reloadData()
    }
    
    func animatePlayerHeight(to height: Int, withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            self.playerViewHeight.constant = CGFloat(height)
            self.view.layoutIfNeeded()
        }
    }


}
