//
//  LibraryTableViewCell.swift
//  Music
//
//  Created by Michael Buss Andersen on 15/04/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageArt: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func layoutSubviews() {
        configureCell(from: "Albums") // TODO: - Replace temporary variable "Album". Should be passed from prior VC
    }
    
    private func configureCell(from sorting: String) {
        var cornerRadius: CGFloat = 0
        switch sorting {
        case "Artists":
            cornerRadius = (imageArt.frame.width)/2
        case "Albums", "Songs":
            cornerRadius = 6
        default:
            print("Sorting did not match any case")
            break
        }
        imageArt.layer.cornerRadius = cornerRadius
        imageArt.clipsToBounds = true
    }

}
