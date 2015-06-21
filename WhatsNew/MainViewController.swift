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
        
        println("Happy Pugs started...")
        
        
        //Option to post alert via a NSURL
        WhatsNewController.infoPageURL = NSURL(string: "http://infusionsoft.com")!
        WhatsNewController.displayFromHTMLIfNecessary(self, embedded:true)

        
        
        //Option to post alert via an NSString
//        WhatsNewController.infoString = "-Improved Pug tail control. \n-Pugs no longer randomly pee. \n-Fixed bug where Pugs were chasing Siri."
//        WhatsNewController.displayFromStringIfNecessary(self)
        
        
        
    }
}