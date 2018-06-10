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
    
    let player = MPMusicPlayerApplicationController.applicationQueuePlayer
    var myMediaQuery = MPMediaQuery.songs()
    
    func playMusic(withPersistentID persistentID: MPMediaEntityPersistentID) {
    
//        let query = MPMediaQuery()
//        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
//        query.addFilterPredicate(predicate)
        player.setQueue(with: MPMediaQuery.songs())
        player.play()
    }
    
    func queueMusic(withSet set: Set<MPMediaEntityPersistentID>) {
        myMediaQuery.filterPredicates = NSSet(object: set) as? Set<MPMediaPredicate>
        player.setQueue(with: myMediaQuery)
        player.play()
    }
    
    func pauseMusic(){
        player.pause()
    }
    
    func resumeMusic(){
        player.play()
    }
    
    func skipToNext(){
        player.skipToNextItem()
    }
    
    func skipToPrevious(){
        player.skipToPreviousItem()
    }
    
}
