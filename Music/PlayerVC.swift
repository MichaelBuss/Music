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
    
    @IBOutlet weak var playerStackView: UIStackView!
    // MARK: - Player buttons
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var queueCollectionViewSpacingConstraint: NSLayoutConstraint!
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    var targetHeight = 64

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        scrubber.translatesAutoresizingMaskIntoConstraints = true
        scrubber.setThumbImage(#imageLiteral(resourceName: "Thumb"), for: .normal) // Sets Thumb image on scrubber
        controlsVisibility(isHidden: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playerControls(_ sender: UIButton) {
        switch sender {
        case playButton:
            print("Play Pressed")
            playMusic(withTitle: "Burn (Gryffin Remix)")
            
        case skipButton:
            print("Skip Pressed")
            musicPlayer.skipToNextItem()
            
        case previousButton:
            print("Previous Pressed")
            musicPlayer.skipToPreviousItem()
            
        case shuffleButton:
            print("Shuffle Pressed")
            musicPlayer.shuffleMode = .songs
            
        case repeatButton:
            print("Repeat Pressed")
            
        default:
            print("did you just press me?")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("Touches began on Player View")
        
        let parentViewHeight = Int((parent?.view.frame.height)!)

        if let parentNavigationBarHeight = parent?.navigationController?.navigationBar.frame.height {
        
        print(parentNavigationBarHeight)
            // MARK: - Bad implementation, needs fixing
            if targetHeight == parentViewHeight + Int(parentNavigationBarHeight) {
                targetHeight = 64
                controlsVisibility(isHidden: true)
            } else {
                targetHeight = parentViewHeight + Int(parentNavigationBarHeight)
                controlsVisibility(isHidden: false)
            }
        }
        
        let playerStateNotification: [String : Int] = ["targetHeight" : targetHeight]

        NotificationCenter.default.post(
            name: Notification.Name("ExpandPlayer"),
            object: self,
            userInfo: playerStateNotification)

    }
    
    private func controlsVisibility(isHidden hidden : Bool) {
        print("heklo")
        if hidden == true {
            queueCollectionViewSpacingConstraint.constant = 0
            playerStackView.alignment = .trailing
        } else {
            queueCollectionViewSpacingConstraint.constant = 8
            playerStackView.alignment = .center
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
