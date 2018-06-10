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
    
    let player = MPMusicPlayerApplicationController.systemMusicPlayer.
    var myMediaQuery = MPMediaQuery.songs()
    
    func playMusic(withPersistentID persistentID: MPMediaEntityPersistentID) {
    
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: persistentID, forProperty: MPMediaItemPropertyPersistentID)
        query.addFilterPredicate(predicate)
        player.setQueue(with: myMediaQuery)
        player.play()
//        sendCurrentPlayerStateNotification()
    }
    
    func queueMusic(fromIndex: Int, finalIndex: Int) {
        
//        var toQueue = myMediaQuery.collections!
        
//        print(toQueue)
//
//        toQueue.removeFirst(finalIndex-fromIndex)
//        for elements in toQueue {
//        }
//        player.play()


//        sendCurrentPlayerStateNotification()
    }
    
    func pauseMusic(){
        player.pause()
//        sendCurrentPlayerStateNotification()
    }
    
    func resumeMusic(){
        player.play()
//        sendCurrentPlayerStateNotification()
    }
    
    func skipToNext(){
        player.skipToNextItem()

//        sendCurrentPlayerStateNotification()

    }
    
    func skipToPrevious(){
        player.skipToPreviousItem()

//        sendCurrentPlayerStateNotification()

    }
    
    func sendCurrentPlayerStateNotification(){
        let playerStateNotification: [String : MPMusicPlaybackState] = ["currentPlayerState" : player.playbackState]
        NotificationCenter.default.post(
        name: Notification.Name("currentPlayerState"),
        object: self,
        userInfo: playerStateNotification)
    }
    
}
