//
//  ForYouVC.swift
//  Music
//
//  Created by Michael Buss Andersen on 02/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class ForYouVC: MainViewController {

    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var playerView: UIView!
    private var playerObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerViewHeightGeneric = playerViewHeight
        // Do any additional setup after loading the view.
    }
}
