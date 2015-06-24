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
        
        //-----Option to post alert via a NSURL
        
        WhatsNewController.infoPageURL = NSURL(string: "http://infusionsoft.com")! //customize url
        WhatsNewController.storyboardFileName = NSString(string: "WhatsNew") //only change for custom storyboard
        WhatsNewController.displayFromHTMLIfNecessary(self, embedded:true) //embed content or just use safari popup?
      
        
        
//      //-----Option to post alert via an NSString
        
//      WhatsNewController.infoString = "-Pugs no longer randomly pee. \n-Fixed bug where Pugs were chasing Siri."
//      WhatsNewController.displayFromStringIfNecessary(self)
        
        
        
    }
}
