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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    @IBOutlet weak var fullPlayerStack: UIStackView!
    // MARK: - Player buttons
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    let musicPlayer = MusicPlayer()

    var targetHeight = 58

    private var playerObserver: NSObjectProtocol?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View will appear")
        playerObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name("currentPlayerState"),
            object: nil,
            queue: OperationQueue.main,
            using: {notification in
                print("Recieved Notification with \(notification.name)")
                if let currentPlayerState = notification.userInfo!["currentPlayerState"] as? MPMusicPlaybackState {
                    switch currentPlayerState {
                    case .playing:
                        print("music is playing")
                        self.playButton.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
                    case .paused:
                        print("music is paused")
                        self.playButton.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
                    case .stopped:
                        print("music is stopped")
                        self.playButton.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
                    case .seekingBackward:
                        print("music is seeking back")
                    case .seekingForward:
                        print("music is seeking forward")
                    case .interrupted:
                        print("music is interrupted")
                    }
                    self.updatePlayerLabels()
                }
        }
        )
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        scrubber.translatesAutoresizingMaskIntoConstraints = true
        scrubber.setThumbImage(#imageLiteral(resourceName: "Thumb"), for: .normal) // Sets Thumb image on scrubber
        controlsVisibility(isHidden: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View did disappear")
        if let observer = self.playerObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @IBAction func playerControls(_ sender: UIButton) {
        switch sender {
        case playButton:
            print("Play Pressed")
            
            if MPMusicPlayerController.systemMusicPlayer.playbackState == .playing {
                print("music is playing")
                musicPlayer.pauseMusic()
            } else {
                print("music is paused")
                musicPlayer.resumeMusic()
            }
            
        case skipButton:
            print("Skip Pressed")
            musicPlayer.skipToNext()
            
        case previousButton:
            print("Previous Pressed")
            musicPlayer.skipToPrevious()
            
        case shuffleButton:
            print("Shuffle Pressed")
//            musicPlayer.shuffleMode = .songs
            
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
    
    // respond to touch inside the playerVC
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches ended on Player View")
        calculateAndSendPlayerHeightNotification()
    }
    
    private func controlsVisibility(isHidden hide : Bool) {
        let duration = 0.5
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
        }
    }
    
    private func calculateAndSendPlayerHeightNotification() {
        let parentViewHeight = Int((parent?.view.frame.height)!)
        
        if let parentNavigationBarHeight = parent?.navigationController?.navigationBar.frame.height {
            
            print(parentNavigationBarHeight)
            // MARK: - Bad implementation, needs fixing
            if targetHeight == parentViewHeight {
                targetHeight = 58
                controlsVisibility(isHidden: true)
            } else {
                targetHeight = parentViewHeight
                controlsVisibility(isHidden: false)
            }
        }
        
        let playerStateNotification: [String : Int] = ["targetHeight" : targetHeight]
        NotificationCenter.default.post(
            name: Notification.Name("ExpandPlayer"),
            object: self,
            userInfo: playerStateNotification)
    }
    
    private func updatePlayerLabels(){
        titleLabel.text = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.title
        artistLabel.text = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.artist
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
