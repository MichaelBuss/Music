//
//  MusicPlayer.swift
//  Music
//
//  Created by Michael Buss Andersen on 09/06/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicPlayer: MPMusicPlayerController {
    
    let musicPlayer = applicationMusicPlayer
    
    func playMusic(withPersistentID persistentID: MPMediaEntityPersistentID) {
        musicPlayer.stop()
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        musicPlayer.setQueue(with: query)
        musicPlayer.play()
    }
    
}
