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
    
    let player = MPMusicPlayerApplicationController.systemMusicPlayer
    
    func playMusic(withPersistentID persistentID: MPMediaEntityPersistentID) {
    
        let query = MPMediaQuery.songs()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        player.setQueue(with: query)
        player.play()
    }
    
    func queueMusic(fromIndex: Int, finalIndex: Int, withPersistentID persistentID: MPMediaEntityPersistentID) {
        
        let query = MPMediaQuery.songs()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        let toQueue = MPMusicPlayerMediaItemQueueDescriptor.init(query: query)
        
//        print(toQueue.startItem?.title)

        player.append(toQueue)

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
