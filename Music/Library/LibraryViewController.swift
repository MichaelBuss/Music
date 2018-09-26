//
//  LibraryTableViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 15/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class LibraryViewController: MainViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    let musicPlayer = MusicPlayer()
    var query = MPMediaQuery()
    var allMediaItems: [MPMediaItemCollection]?
    private let libraryTableViewCell = LibraryTableViewCell()
    private var style: LibraryTableViewCell.style = .artists
    
    // MARK: - Outlets
    @IBOutlet weak var playerContainerView: UIView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var libraryTableView: UITableView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    
    // MARK: - Life cycle methods

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortMusic(byStyle: style)
        print("loaded")
        playerViewHeightGeneric = playerViewHeight
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allMediaItems?.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath)
        if let libraryCell = cell as? LibraryTableViewCell {
            tableView.indicatorStyle = UIScrollViewIndicatorStyle.white
            
            // Populates table view cells with data
            
            let imageSize = libraryCell.coverArt.bounds.size
            let itemTitle = getItemName(at: indexPath.row)
            let coverArt = allMediaItems?[indexPath.row].representativeItem?.artwork?.image(at: imageSize) ?? #imageLiteral(resourceName: "Missing Artwork")
            
            libraryCell.setupCell(withImage: coverArt, withItemTitle: itemTitle, withStyle: style)
        }
        return cell
    }

    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = (tableView.cellForRow(at: indexPath) as? LibraryTableViewCell)?.itemTitle{
            print(cell)
            var predicate = MPMediaPropertyPredicate()
        
            tableView.deselectRow(at: indexPath, animated: true) // Un-highlights selected row
            print("Tapped tableView cell indexPath is \(indexPath.row)")
            
            switch sortSegmentedControl.selectedSegmentIndex {
            case 0: // Artists
                print("Pressed an item in Artists sorted segmented control")
                query = .artists()
                predicate = MPMediaPropertyPredicate(
                    value: query.items?[indexPath.row].artistPersistentID,
                    forProperty: MPMediaItemPropertyArtistPersistentID,
                    comparisonType:MPMediaPredicateComparison.equalTo)
                query.addFilterPredicate(predicate)
                performSegue(withIdentifier: "MusicCollectionDetailSegue", sender: self)
            case 1: // Albums
                print("Pressed an item in Albums sorted segmented control")
                query = .albums()
                predicate = MPMediaPropertyPredicate(
                    value: query.items?[indexPath.row].albumPersistentID,
                    forProperty: MPMediaItemPropertyAlbumPersistentID,
                    comparisonType:MPMediaPredicateComparison.equalTo)
                query.addFilterPredicate(predicate)
                performSegue(withIdentifier: "MusicCollectionDetailSegue", sender: self)
            case 2: // Songs
                print("Pressed an item in Songs sorted segmented control")
                if let tappedItemID = allMediaItems?[indexPath.row].persistentID {
                    musicPlayer.playMusic(withPersistentID: tappedItemID)
                }
            default: break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let musicCollectionDetailViewController = segue.destination as? MusicCollectionDetailViewController {
            switch sortSegmentedControl.selectedSegmentIndex {
            case 0: // Artists
                print("Pressed an item in Artists sorted segmented control")
                musicCollectionDetailViewController.query = query
            case 1: // Albums
                print("Pressed an item in Albums sorted segmented control")
                musicCollectionDetailViewController.query = query
            case 2: // Songs
                print("Pressed an item in Songs sorted segmented control")
            default: break
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func sortSegmentedControlDidChange(_ sender: UISegmentedControl) {
        switch sortSegmentedControl.selectedSegmentIndex{
            case 0:
                self.style = .artists
            case 1:
                self.style = .albums
            case 2:
                self.style = .songs
            default: break
        }
        sortMusic(byStyle: style)
        updateTable()
    }
    
    private func getItemName(at indexPath: Int) -> String {
        switch style {
        case .artists:
            return (allMediaItems?[indexPath].representativeItem?.albumArtist)!
        case .albums:
            return (allMediaItems?[indexPath].representativeItem?.albumTitle)!
        case .songs:
            return (allMediaItems?[indexPath].representativeItem?.title)!
        }
        
    }
    
    private func sortMusic(byStyle style: LibraryTableViewCell.style){
        let query = MPMediaQuery()
        switch style {
        case .artists:
            query.groupingType = MPMediaGrouping.albumArtist
        case .albums:
            query.groupingType = MPMediaGrouping.album
        case .songs:
            query.groupingType = MPMediaGrouping.title
        }
        print("Sorts music by \(style)")
        allMediaItems = query.collections
    }
    
    @IBAction func dotsMenu(_ sender: Any) {
        presentActionSheet(forTitle: "Song Name")
    }
    
    // fundtion to dismiss the alerController if the background is tabbed
    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    private func presentActionSheet(forTitle title: String){
        let actionSheetController = UIAlertController(title: title, message: "That's pretty good!", preferredStyle: .alert)
        
        // add Queue action
        let queuAction = UIAlertAction(title: "Queue", style: .default) { action in
            // ...
        }
        actionSheetController.addAction(queuAction)
        
        // add Heart Action
        let loveAction = UIAlertAction(title: "❤️ Love!", style: .default) { action in
            // ...
        }
        actionSheetController.addAction(loveAction)
        
        // add Dislike Action
        let dislikeAction = UIAlertAction(title: "💔 Dislike!", style: .destructive) { action in
            // ...
        }
        actionSheetController.addAction(dislikeAction)
        
        // add Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print(action)
        }
        actionSheetController.addAction(cancelAction)
        
        // present the viewController
        self.present(actionSheetController, animated: true) {
            // enables the controller to detect if the background is tabbed
            actionSheetController.view.superview?.isUserInteractionEnabled = true
            actionSheetController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            // ...
        }
    }
    
    // swipe action for leading part of tableView
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let queueAction = UIContextualAction(style: .normal, title: "Queue") { (action, view, completionHandler) in
            print("Queue Action Tapped")
            
            self.musicPlayer.queueMusic(withPersistentID: (self.allMediaItems?[indexPath.row].persistentID)!)

            completionHandler(true)
            
        }
        queueAction.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [queueAction])
        return configuration
    }
    
    func makeSetFromTappedIndexToButtomOfList(indexPath: IndexPath, numberOfRows: Int) -> Set<MPMediaEntityPersistentID> {
        var querySet = Set<MPMediaEntityPersistentID>()
        for item in indexPath.row..<numberOfRows{
            querySet.insert((allMediaItems?[item].persistentID)!)
        }
        return querySet
    }
    
    // swipe action for trailing part of tableView
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let loveAction = UIContextualAction(style: .normal, title: "❤️ Love!") { (action, view, completionHandler) in
            print("Love Action Tapped")
            completionHandler(true)
        }
        loveAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [loveAction])
        return configuration
    }
    
    private func updateTable() {
        print("Updating table")
        libraryTableView.reloadData()
    }
    
}
