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
        if hide == true { // Hide elements
            parent?.navigationController?.setNavigationBarHidden(false, animated: true)
            fullPlayerStack.alignment = .trailing
            UIView.animate(withDuration: 2, animations: {
                self.dragHandleView.alpha = 0
                self.scrubberView.alpha = 0
                self.playerView.backgroundColor = UIColor(named: "UI Color Dark")
            }, completion: { _ in // Runs when the animation has finished
                print("Finished animating OUT")
            })
        } else { // Show elements
            parent?.navigationController?.setNavigationBarHidden(true, animated: true)
            fullPlayerStack.alignment = .center
            UIView.animate(withDuration: 2, animations: {
                self.dragHandleView.alpha = 1
                self.scrubberView.alpha = 1
                self.playerView.backgroundColor = UIColor.black
            }, completion: { _ in // Runs when the animation has finished
                print("Finished animating IN")
            })
        }

        shuffleButton.isHidden = hide
        previousButton.isHidden = hide
        repeatButton.isHidden = hide
        playerQueueCollectionView.isHidden = hide
        headerView.isHidden = hide
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
