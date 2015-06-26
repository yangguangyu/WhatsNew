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
        
        
        // CHOOSE THIS
        //-----Option to post alert via a NSURL

        let whatsNewController = WhatsNewController()
        whatsNewController.infoPageURL = NSURL(string: "http://infusionsoft.com") //customize url
        whatsNewController.displayFromHTMLIfNecessary(self, embedded:true)
    
        
        // OR CHOOSE THIS
        //-----Option to post alert via an NSString

//        let whatsNewController = WhatsNewController()
//        whatsNewController.infoString = "-Pugs no longer randomly pee. \n-Fixed bug where Pugs were chasing Siri."
//        whatsNewController.displayFromStringIfNecessary(self)
    
        
        
    }
}
