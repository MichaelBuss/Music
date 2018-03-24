//
//  Scrubber.swift
//  Music
//
//  Created by Michael Buss Andersen on 24/03/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class Scrubber: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:0, y:0, width: #imageLiteral(resourceName: "Track Played").size.width, height: #imageLiteral(resourceName: "Track Played").size.height)
    }
    
    override func maximumTrackImage(for state: UIControlState) -> UIImage? {
        return #imageLiteral(resourceName: "Track Unplayed").resizableImage(withCapInsets: .zero, resizingMode: .tile)
    }
    
    override func minimumTrackImage(for state: UIControlState) -> UIImage? {
        return #imageLiteral(resourceName: "Track Played").resizableImage(withCapInsets: .zero, resizingMode: .tile)
    }

}
