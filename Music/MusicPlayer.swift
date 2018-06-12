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
        
        //creates a query containing only the one chosen song
        
        let query = MPMediaQuery.songs()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        
        let isolatedQuery = MPMediaQuery.songs()
        let toQueue = MPMusicPlayerMediaItemQueueDescriptor.init(query: isolatedQuery)
        toQueue.startItem = query.items?[0]
        
        player.setQueue(with: toQueue)
        player.play()
}
    
    func queueMusic(withPersistentID persistentID: MPMediaEntityPersistentID) {
        
        //creates a query containing only the one chosen song
        let query = MPMediaQuery.songs()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        
        //puts the one song from query into a format that can be queued
        let toQueue = MPMusicPlayerMediaItemQueueDescriptor.init(query: query)
        
        //print the name of the song
//        let queuedSongTitle: String = query.items![0].title!
//        print(queuedSongTitle)
        
        //appends the song to the queue
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
    
    func cycleRepeatMode(){
        let currentMode = player.repeatMode
        switch currentMode {
        case .default:
            player.repeatMode = .none
        case .none:
            player.repeatMode = .one
        case .one:
            player.repeatMode = .all
        case .all:
            player.repeatMode = .none
        }
        
        
        
    }
}
