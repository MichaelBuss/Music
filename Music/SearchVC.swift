//
//  SearchVC.swift
//  Music
//
//  Created by Michael Buss Andersen on 02/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class SearchVC: MainViewController {

    @IBOutlet weak var playerViewHeight: NSLayoutConstraint!
    private var playerObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerViewHeightGeneric = playerViewHeight
        // Do any additional setup after loading the view.
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
