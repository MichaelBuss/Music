//
//  AlbumHeaderTableViewCell.swift
//  Music
//
//  Created by Michael Buss Andersen on 12/06/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class AlbumHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var coverArt: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
