//
//  MainViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit




class MainViewController: UIViewController {
 
    //MARK: View Dids
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    override func prefersStatusBarHidden() -> Bool {
    //        return true
    //    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        
        // CHOOSE THIS
        //-----Option to post alert via a NSURL
        
        let whatsNewController = WhatsNewController()
        whatsNewController.appViewController = (self)
        whatsNewController.infoPageURL = NSURL(string: "http://infusionsoft.com") //edit url
        whatsNewController.displayFromHTMLIfNecessary(embedded: true) //edit true or false

        
        
        // OR CHOOSE THIS
        //-----Option to post alert via an NSString

        //        let whatsNewController = WhatsNewController()
        //        whatsNewController.appViewController = (self)
        //        whatsNewController.infoString = "-Pugs no longer randomly pee. \n-Fixed bug where Pugs were chasing Siri." //edit text
        //        whatsNewController.displayFromStringIfNecessary()
        
    
        
        
    }
}
