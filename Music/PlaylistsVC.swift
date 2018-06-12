//
//  PlaylistVC.swift
//  Music
//
//  Created by Michael Buss Andersen on 02/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class PlaylistsVC: UIViewController {

    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    private var playerObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPlayerObserver()
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Animate Player Height. Copied to other VCs as well
    private func addPlayerObserver(){
        playerObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name("ExpandPlayer"),
            object: nil,
            queue: OperationQueue.main,
            using: {notification in
                print("Recieved Notification with \(notification.name)")
                if let height = notification.userInfo!["targetHeight"] as? CGFloat {
                    self.animatePlayerHeight(to: height, withDuration: 0.5)
                }
        }
        )
    }
    
    private func animatePlayerHeight(to height: CGFloat, withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            self.playerViewHeight.constant = CGFloat(height)
            self.view.layoutIfNeeded()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
