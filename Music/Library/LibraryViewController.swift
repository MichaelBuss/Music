//
//  LibraryTableViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 15/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    let musicPlayer = MusicPlayer()
    let query = MPMediaQuery()
    var allMediaItems: [MPMediaItemCollection]?
    private let libraryTableViewCell = LibraryTableViewCell()
    private var playerObserver: NSObjectProtocol?
    private var currentSorting = "Artists"
    
    // MARK: - Outlets
    @IBOutlet weak var playerContainerView: UIView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var libraryTableView: UITableView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    
    // MARK: - Life cycle methods
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
                    self.animatePlayerHeight(to: height, withDuration: 0.5)
                }
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortMusic(by: currentSorting)
        print("loaded")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View did disappear")
        if let observer = self.playerObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        
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
            let imageSize = libraryCell.imageArt.bounds.size
            libraryCell.label.text = getItemName(at: indexPath.row)
            libraryCell.imageArt.image = allMediaItems?[indexPath.row].representativeItem?.artwork?.image(at: imageSize)
        }
        return cell
    }

    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = (tableView.cellForRow(at: indexPath) as? LibraryTableViewCell)?.label{
            print(cell)
        }
        tableView.deselectRow(at: indexPath, animated: true) // Un-highlights selected row
        print("Tapped tableView cell indexPath is \(indexPath.row)")
        
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0: // Artists
            print("Pressed an item in Artists sorted segmented control")
//            let secondVC = storyboard?.instantiateViewController(withIdentifier: "ArtistAndAlbumDetailTableViewControllerID") as! UITableViewController
//            present(secondVC, animated: true, completion: nil)
//            performSegue(withIdentifier: "ArtistAndAlbumDetailTableViewControllerID", sender: self)
        case 1: // Albums
            print("Pressed an item in Artists sorted segmented control")
        case 2: // Songs
            print("Pressed an item in Songs sorted segmented control")
            if let tappedItemID = allMediaItems?[indexPath.row].persistentID {
                musicPlayer.playMusic(withPersistentID: tappedItemID)
            }
        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let artistAndAlbumDetailTableViewController = segue.destination as? ArtistAndAlbumDetailTableViewController else { return }
        artistAndAlbumDetailTableViewController.data = ["one", "two"]
        artistAndAlbumDetailTableViewController.header = ["hone", "htwo"]
        artistAndAlbumDetailTableViewController.query = MPMediaQuery.songs()
    }
    
    // MARK: - Actions
    @IBAction func sortSegmentedControlDidChange(_ sender: UISegmentedControl) {
        switch sortSegmentedControl.selectedSegmentIndex{
            case 0:
                currentSorting = "Artists"
            case 1:
                currentSorting = "Albums"
            case 2:
                currentSorting = "Songs"
            default: break
        }
        sortMusic(by: currentSorting)
        updateTable()
    }
    
    private func getItemName(at indexPath: Int) -> String {
        switch currentSorting {
        case "Artists":
            return (allMediaItems?[indexPath].representativeItem?.artist)!
        case "Albums":
            return (allMediaItems?[indexPath].representativeItem?.albumTitle)!
        case "Songs":
            return (allMediaItems?[indexPath].representativeItem?.title)!
        default:
            print("Case \(currentSorting) was not matched")
            return "Case \(currentSorting) was not matched"
        }
        
    }
    
    private func sortMusic(by category: String){
        switch category {
        case "Artists":
            query.groupingType = MPMediaGrouping.albumArtist
            print("Sorts music by artists")
        case "Albums":
            query.groupingType = MPMediaGrouping.album
            print("Sorts music by albums")
        case "Songs":
            query.groupingType = MPMediaGrouping.title
            print("Sorts music by songs")
        default:
            print("Sorting went wrong because case was not met")
        }
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
    
    private func animatePlayerHeight(to height: Int, withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            self.playerViewHeight.constant = CGFloat(height)
            self.view.layoutIfNeeded()
        }
    }

    
    
}
