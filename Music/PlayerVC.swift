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
    @IBOutlet var playerView: UIView!
    @IBOutlet weak var playerQueueCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrubberView: UIView!
    @IBOutlet weak var scrubber: UISlider!
    @IBOutlet weak var scrubberHeight: NSLayoutConstraint!
    @IBOutlet weak var dragHandleView: UIView!
    @IBOutlet weak var dragHandle: UIButton!
    
    @IBOutlet weak var fullPlayerStack: UIStackView!
    // MARK: - Player buttons
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    var targetHeight = 58

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        scrubber.translatesAutoresizingMaskIntoConstraints = true
        scrubber.setThumbImage(#imageLiteral(resourceName: "Thumb"), for: .normal) // Sets Thumb image on scrubber
        controlsVisibility(isHidden: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playerControls(_ sender: UIButton) {
        switch sender {
        case playButton:
            print("Play Pressed")

            if (AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint) {
                print("another application with a non-mixable audio session is playing audio")
                musicPlayer.pause()
            }
            else {
                playMusic(withTitle: "Burn (Gryffin Remix)")
                musicPlayer.play()
            }
            
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
            print("Sender button did not match any case")
        }
    }
    
    
    @IBAction func dragHandle(_ sender: UIButton) {
        print("dragHandle touched")
        calculateAndSendPlayerHeightNotification()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches ended on Player View")
        calculateAndSendPlayerHeightNotification()
    }
    
    private func controlsVisibility(isHidden hide : Bool) {
        let duration = 2.0
        if hide == true { // Hide elements
//            parent?.navigationController?.setNavigationBarHidden(false, animated: true)
            self.headerView.isHidden = true
            self.scrubberView.isHidden = true
            self.dragHandleView.isHidden = true
            UIView.animate(withDuration: duration) {
                self.playerView.backgroundColor = UIColor(named: "UI Color Dark")
                self.shuffleButton.isHidden = true
                self.previousButton.isHidden = true
                self.repeatButton.isHidden = true
                self.playerQueueCollectionView.isHidden = true
                self.fullPlayerStack.alignment = .trailing
            }

        } else { // Show elements
//            parent?.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(
                withDuration: duration,
                animations: {
                    self.playerView.backgroundColor = UIColor.black
                    self.shuffleButton.isHidden = false
                    self.previousButton.isHidden = false
                    self.repeatButton.isHidden = false
                    self.playerQueueCollectionView.isHidden = false
                    self.fullPlayerStack.alignment = .center
                },
                completion: { _ in
                    self.headerView.isHidden = false
                    self.scrubberView.isHidden = false
                    self.dragHandleView.isHidden = false
                }
            )
            
//            UIView.animate(
//                withDuration: duration/2,
//                delay: duration/2,
//                animations: {
//                self.scrubberView.isHidden = false
//                }
//            )
        }
        
//        UIView.animate(withDuration: 2) {
//            self.dragHandleView.isHidden = hide
//            self.scrubberView.isHidden = hide
//            self.shuffleButton.isHidden = hide
//            self.previousButton.isHidden = hide
//            self.repeatButton.isHidden = hide
//            self.playerQueueCollectionView.isHidden = hide
//            self.headerView.isHidden = hide
//        }
        
//        dragHandleView.isHidden = hide
//        scrubberView.isHidden = hide
    }
    
    private func calculateAndSendPlayerHeightNotification() {
        let parentViewHeight = Int((parent?.view.frame.height)!)
        
        if let parentNavigationBarHeight = parent?.navigationController?.navigationBar.frame.height {
            
            print(parentNavigationBarHeight)
            // MARK: - Bad implementation, needs fixing
            if targetHeight == parentViewHeight + Int(parentNavigationBarHeight) {
                targetHeight = 58
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
