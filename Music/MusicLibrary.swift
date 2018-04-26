//
//  MusicLibrary.swift
//  Music
//
//  Created by Michael Buss Andersen on 26/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicLibrary: MPMediaLibrary {
    
    override init() {
        super.init()
        for _ in 1...100 {self.songs.append(song)} // Loads songs[] with 100 of the same fake song.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let song: (title: String, artist: String, album: String, coverArt: UIImage) = ("Under Your Spell", "Desire" , "Drive (Original Motion Picture Soundtrack)", #imageLiteral(resourceName: "CoverDrive"))
    
    lazy var songs = [song]
    
}
