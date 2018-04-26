//
//  PlayerVC.swift
//  Music
//
//  Created by Michael Buss Andersen on 26/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func play(_ sender: Any) {
        print("Play Pressed")
//        animatePlayerHeight(to: 300, withDuration: 0.5)
    }
    
    
    private func animatePlayerHeight(to height: Int, withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            self.animatePlayerHeight(to: 300, withDuration: 0.5)
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
