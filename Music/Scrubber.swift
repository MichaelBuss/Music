//
//  Scrubber.swift
//  Music
//
//  Created by Michael Buss Andersen on 24/03/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class Scrubber: UISlider {
    
    var trackImageOffsetCorrection = -4 // Corrests odd offset caused by... UISlider?
    
//    override func thumbImage(for state: UIControlState) -> UIImage? {
//        return #imageLiteral(resourceName: "Thumb")
//    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:0, y:0, width: bounds.size.width, height: #imageLiteral(resourceName: "Track Played").size.height)
    }
    
    override func maximumTrackImage(for state: UIControlState) -> UIImage? {
        return #imageLiteral(resourceName: "Track Unplayed").resizableImage(withCapInsets: .init(top: 0, left: 0, bottom: 0, right: CGFloat(trackImageOffsetCorrection)), resizingMode: .tile)
//        return #imageLiteral(resourceName: "Track Unplayed").resizableImage(withCapInsets: .zero, resizingMode: .tile)
    }
    
    override func minimumTrackImage(for state: UIControlState) -> UIImage? {
        return #imageLiteral(resourceName: "Track Played").resizableImage(withCapInsets: .init(top: 0, left: CGFloat(trackImageOffsetCorrection), bottom: 0, right: 0), resizingMode: .tile)
//        return #imageLiteral(resourceName: "Track Played").resizableImage(withCapInsets: .zero, resizingMode: .tile)
    }
    
    
//    override func frame(forAlignmentRect alignmentRect: CGRect) -> CGRect {
//        return CGRect(x:0, y:0, width: bounds.size.width, height: bounds.size.height)
//    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
