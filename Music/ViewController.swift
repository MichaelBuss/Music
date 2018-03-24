//
//  ViewController.swift
//  Music
//
//  Created by Michael Buss Andersen on 24/03/2018.
//  Copyright © 2018 NoobLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrubber: UISlider!
    @IBOutlet weak var scrubberLabel: UILabel!
    @IBAction func scrubberAction(_ sender: Scrubber) {
        scrubberLabel.text = String(Int(scrubber.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrubber.translatesAutoresizingMaskIntoConstraints = true
        scrubber.setThumbImage(#imageLiteral(resourceName: "Thumb"), for: .normal)
        scrubberLabel.text = String(Int(scrubber.value))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

