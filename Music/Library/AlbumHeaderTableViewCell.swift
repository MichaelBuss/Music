//
//  AlbumHeaderTableViewCell.swift
//  Music
//
//  Created by Michael Buss Andersen on 12/06/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class AlbumHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var albumCoverArt: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumYear: UILabel!
    @IBOutlet weak var albumNumberOfSongs: UILabel!
    @IBOutlet weak var albumDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(withImage image: UIImage,
                   withAlbumTitle albumTitle: String,
                   withAlbumYear albumYear: Int,
                   withAlbumNumberOfSongs albumNumberOfSongs: Int,
                   withAlbumDuration albumDuration: Double) {
        self.albumCoverArt.layer.cornerRadius = self.albumCoverArt.frame.width/6
        self.albumCoverArt.image = image
        self.albumTitle.text = albumTitle
        self.albumYear.text = String(albumYear)
        self.albumNumberOfSongs.text = "\(String(albumNumberOfSongs)) Songs"
        self.albumDuration.text = "\(String(Int(albumDuration))) Minutes"
    }

}
