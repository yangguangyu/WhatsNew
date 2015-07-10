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
    
    override func viewDidAppear(animated: Bool) {
        
       
        
        
        
        // CHOOSE THIS
        //-----Option to post alert via a NSURL
        
      let whatsNewController = WhatsNewController()
      whatsNewController.appViewController = (self)
      whatsNewController.infoPageURL = NSURL(string: "https://en.wikipedia.org/wiki/Pug") //edit url
      whatsNewController.displayFromURLIfNecessary(embedded: true) //edit true or false
    //TODO: rename to include paramater embedded for displayFromURLIfNecessary inside title of method
        
        
        
        
        
        
        
        // OR CHOOSE THIS
        //-----Option to post alert via an NSString

//        let whatsNewController = WhatsNewController()
//        whatsNewController.appViewController = (self)
//        whatsNewController.infoString = "-Pugs no longer deficate when barking.\n-Pugs with three legs now have expected fourth leg in appropriate place.\n-When repositioning collar, Pug's head no longer separates from body." //edit text
//        whatsNewController.displayFromStringIfNecessary()

    
        
        
        
        
        
        
// (optional) USE THIS to customize your webview
        //       whatsNewController.customButtonColor = UIColor.yellowColor()
        //       whatsNewController.customBackgroundColor = UIColor.redColor()
        
        
// (alternatively) If you don't want extra code, you can set the Tint Color of each button in the What's New view controller and the background color of the WhatsNewViewController view.  
        
    }


}



