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
    @IBOutlet weak var queueCollectionView: UICollectionView!
    @IBOutlet weak var topStackView: UIView!
    @IBOutlet weak var scrubber: UISlider!
    
    // MARK: - Player buttons
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var queueCollectionViewSpacingConstraint: NSLayoutConstraint!
    
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
        
        if targetHeight == parentHeight {
            targetHeight = 58
            controlsVisibility(isHidden: true)
        } else {
            targetHeight = parentHeight
            controlsVisibility(isHidden: false)
        }
        
        let expandNotification: [String : Int] = ["height" : targetHeight]

        NotificationCenter.default.post(
            name: Notification.Name("ExpandPlayer"),
            object: self,
            userInfo: expandNotification)
        // MARK: - Bad implementation, needs fixing

    }
    
    private func controlsVisibility(isHidden hidden : Bool) {
        if hidden == true {
            queueCollectionViewSpacingConstraint.constant = 0
        } else {
            queueCollectionViewSpacingConstraint.constant = 8
        }
        shuffleButton.isHidden = hidden
        previousButton.isHidden = hidden
        repeatButton.isHidden = hidden
        queueCollectionView.isHidden = hidden
        topStackView.isHidden = hidden
        scrubber.isHidden = hidden
    }
    
    private func playMusic(withTitle title: String) {
        
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
