//
//  ViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 24/03/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerVC: UIViewController {

    @IBOutlet weak var scrubber: UISlider!
    // Instantiate a new music player
    
    let myMediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    @IBAction func scrubberAction(_ sender: Scrubber) {
        // print("Scrubber changed value")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrubber.translatesAutoresizingMaskIntoConstraints = true
        scrubber.setThumbImage(#imageLiteral(resourceName: "Thumb"), for: .normal) // Sets Thumb image on scrubber

        // Add a playback queue containing all songs on the device
         myMediaPlayer.setQueue(with: MPMediaQuery.songs())
        // Start playing from the beginning of the queue
         myMediaPlayer.play()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

