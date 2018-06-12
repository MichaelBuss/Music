//
//  AlbumSongTableViewCell.swift
//  Music
//
//  Created by Michael Buss Andersen on 11/06/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class AlbumSongTableViewCell: UITableViewCell {

    @IBOutlet weak var songNumber: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(withSongNumber songNumber: String, withText text: String){
        self.songNumber.text = songNumber
        songTitle.text = text
    }

}
