//
//  LibraryTableViewCell.swift
//  Music
//
//  Created by Michael Buss Andersen on 15/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverArt: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    
    func setupCell(withImage image: UIImage, withItemTitle itemTitle: String, withStyle style: style){
        self.coverArt.image = image
        self.itemTitle.text = itemTitle
        var cornerRadius = CGFloat()
        
        switch style {
        case .albums, .songs:
            cornerRadius = self.coverArt.frame.width/6
        case .artists:
            cornerRadius = self.coverArt.frame.width/2
        }
        self.coverArt.layer.cornerRadius = cornerRadius
    }
    
    enum style {
        case albums
        case artists
        case songs
    }

}
