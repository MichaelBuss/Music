//
//  PlayerVC.swift
//  Music
//
//  Created by Michael Buss Andersen on 26/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerVC: UIViewController {
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    var parentHeight = 0
    var targetHeight = 58
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        parentHeight = Int((parent?.view.frame.height)!)
        print("parentHeight: \(parentHeight)")
    }
    
    @IBAction func play(_ sender: Any) {
        print("Play Pressed")
        playMusic(withTitle: "Burn (Gryffin Remix)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches began on Player View")
        
        if targetHeight == parentHeight{
            targetHeight = 58
        } else {
            targetHeight = parentHeight
        }
        let expandNotification: [String : Int] = ["height" : targetHeight]

        NotificationCenter.default.post(
            name: Notification.Name("ExpandPlayer"),
            object: self,
            userInfo: expandNotification)
        // MARK: - Bad implementation, needs fixing

    }
    

    
    func playMusic(withTitle title: String) {
        
        musicPlayer.stop()
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: title, forProperty: MPMediaItemPropertyTitle)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.play()
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
