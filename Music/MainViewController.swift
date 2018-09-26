//
//  MainViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 26/09/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Instantiations
    private var playerObserver: NSObjectProtocol?
    public var playerViewHeightGeneric: NSLayoutConstraint!
    
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addPlayerObserver()
        print("View will appear")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View did disappear")
        if let observer = self.playerObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        
    }
    
    // MARK: - Observer
    func addPlayerObserver(){
        playerObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name("ExpandPlayer"),
            object: nil,
            queue: OperationQueue.main,
            using: {notification in
                print("Recieved Notification with \(notification.name)")
                if let height = notification.userInfo!["targetHeight"] as? CGFloat {
                    animatePlayerHeight(forConstraint: self.playerViewHeightGeneric ,to: height, withDuration: 0.5)
                }
        }
        )
        
        func animatePlayerHeight(forConstraint constraint: NSLayoutConstraint,to height: CGFloat, withDuration duration: Double) {
            UIView.animate(withDuration: duration) {
                constraint.constant = CGFloat(height)
                self.view.layoutIfNeeded()
            }
        }

    }
    // MARK: - Looks
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
