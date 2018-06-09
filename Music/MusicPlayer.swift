//
//  MusicPlayer.swift
//  Music
//
//  Created by Michael Buss Andersen on 09/06/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicPlayer {
    
    let player = MPMusicPlayerController.systemMusicPlayer
    
    func playMusic(withPersistentID persistentID: MPMediaEntityPersistentID) {
    
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        player.setQueue(with: query)
        player.play()
    }
    
    func pauseMusic(){
        player.pause()
    }
    func queueMusic(withPersistentID persistentID: MPMediaEntityPersistentID){
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        player.setQueue(with: query)
    }
    func skipMusic(){
        player.skipToNextItem()
    }
}
