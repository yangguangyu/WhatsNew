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
    
        
//------//-----CHOOSE THIS
        //-----Option to post alert via a NSURL
        
        // (required 1)
        let whatsNewController = WhatsNewController()
        
        //(paste any customizations here)
//        whatsNewController.alertOk = "Yep"
//        whatsNewController.alertNoThanks = "Nope"
//        whatsNewController.alertUpdatedToVersion = "Presenting Version "
//        whatsNewController.alertWouldYouLikeToSeeWhatsNew = "Want to see what is new?"
//        whatsNewController.showOnFirstLaunch = true
//        whatsNewController.firstRunOk = "Sounds good."
//        whatsNewController.firstRunTitle = "Welcome to Happy Pugs!"
//        whatsNewController.firstRunMessage = "Hey, thanks for trying out Happy Pugs!"
//        whatsNewController.customModalTransition = UIModalTransitionStyle.PartialCurl
//        whatsNewController.customButtonColor = UIColor.yellowColor()
//        whatsNewController.customBackgroundColor = UIColor.redColor()
        
        //(required 2)
        whatsNewController.appViewController = (self)
        whatsNewController.alertPageURL = NSURL(string: "https://en.wikipedia.org/wiki/Pug") //edit url
        whatsNewController.displayFromURLIfNeccessaryInsideApp(true) //edit true or false
        
//------//-----OR CHOOSE THIS
        //-----Option to post alert via an NSString
        
        //(required 1)
//        let whatsNewController = WhatsNewController()
//        
        //(paste any customizations here)
////      whatsNewController.alertOk = "Sounds good."
////      whatsNewController.alertUpdatedToVersion = "Presenting Version "
////      whatsNewController.showOnFirstLaunch = true
//        whatsNewController.firstRunOk = "Sounds good."
//        whatsNewController.firstRunTitle = "Welcome to Happy Pugs!"
//        whatsNewController.firstRunMessage = "Hey, thanks for trying out Happy Pugs!"
//        
//        //(required 2)
//        whatsNewController.appViewController = (self)
//        whatsNewController.alertMessage = "-Pugs no longer deficate when barking.\n-Pugs with three legs now have expected fourth leg in appropriate place.\n-When repositioning collar, Pug's head no longer separates from body."
//        whatsNewController.displayFromStringIfNecessary()
        
        
        
        
    }


}



