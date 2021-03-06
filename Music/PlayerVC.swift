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

    var targetHeight: CGFloat = 58

    private var playbackStateDidChangeObserver: NSObjectProtocol?
    private var nowPlayingItemDidChangeObserver: NSObjectProtocol?

    // MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicPlayer.player.beginGeneratingPlaybackNotifications()
        initiatePlaybackStateDidChangeObserver() //Begins listening for notifications
        initaiteNowPlayingItemDidChangeObserver() //Begins listening for notifications
        updateRepeatModeIcon()
        updatePlayerLabels()
    }
    
        var myProperty: Int = 0 {
            didSet {
                print("The value of myProperty changed from \(oldValue) to \(myProperty)")
                scrubber.maximumValue = Float((musicPlayer.player.nowPlayingItem?.playbackDuration)! )
                scrubber.value = Float(musicPlayer.player.currentPlaybackTime)
            }
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
        musicPlayer.player.endGeneratingPlaybackNotifications()
        print("View did disappear")
        if let observer = self.playbackStateDidChangeObserver {
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
            musicPlayer.cycleRepeatMode()
            print("Repeat Pressed")
            updateRepeatModeIcon()
        default:
            print("Sender button did not match any case")
        }
    }
    
    
    @IBAction func dragHandle(_ sender: UIButton) {
        print("dragHandle touched")
        calculateAndSendPlayerHeightNotification()
    }
    
    // Respond to touch inside the playerVC
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches ended on Player View")
        calculateAndSendPlayerHeightNotification()
    }
    
    // Toggels the viibility of controlls
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
        if let parentViewHeight = parent?.view.frame.height {
            if (parent?.navigationController?.navigationBar.frame.height) != nil {
                
                // TODO: - Bad implementation, needs fixing
                if targetHeight == parentViewHeight {
                    targetHeight = 58
                    controlsVisibility(isHidden: true)
                } else {
                    targetHeight = parentViewHeight
                    controlsVisibility(isHidden: false)
                }
            }
        }
        
        let playerStateNotification: [String : CGFloat] = ["targetHeight" : targetHeight]
        NotificationCenter.default.post(
            name: Notification.Name("ExpandPlayer"),
            object: self,
            userInfo: playerStateNotification)
    }
    
    private func updatePlayerLabels(){
        titleLabel.text = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.title
        artistLabel.text = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem?.artist
    }
    
    private func updateRepeatModeIcon(){
        switch musicPlayer.player.repeatMode {
        case .default:
            repeatButton.setImage(#imageLiteral(resourceName: "Repeat"), for: .normal)

        case .none:
            repeatButton.setImage(#imageLiteral(resourceName: "Repeat"), for: .normal)

        case .one:
            repeatButton.setImage(#imageLiteral(resourceName: "Repeat Active Once"), for: .normal)

        case .all:
            repeatButton.setImage(#imageLiteral(resourceName: "Repeat Active"), for: .normal)
            
        }
    }
    
    
    // MARK: - Notification observer instantiation functions
    private func initiatePlaybackStateDidChangeObserver(){
        playbackStateDidChangeObserver = NotificationCenter.default.addObserver( // Update player controlls accordingly
            forName: Notification.Name.MPMusicPlayerControllerPlaybackStateDidChange,
            object: nil,
            queue: OperationQueue.main,
            using:
            { notification in
                print("Recieved Notification with \(notification.name)")
                switch self.musicPlayer.player.playbackState {
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
        })
    }
    
    private func initaiteNowPlayingItemDidChangeObserver(){
        nowPlayingItemDidChangeObserver = NotificationCenter.default.addObserver( // Update player labels accordingly
            forName: Notification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
            object: nil,
            queue: OperationQueue.main,
            using:
            { notification in
                print("Recieved Notification with \(notification.name)")
                self.updatePlayerLabels()
        })
    }

}
