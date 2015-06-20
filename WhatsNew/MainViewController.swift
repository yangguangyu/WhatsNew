//
//  MainViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
 
    
    override func viewDidAppear(animated: Bool) {
        WhatsNewViewController.infoPageURL = NSURL(string: "http://google.com")!
        WhatsNewViewController.displayIfNecessary(self)
    }
}