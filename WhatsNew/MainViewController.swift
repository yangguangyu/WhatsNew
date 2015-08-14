//
//  MainViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        

        //EXAMPLE WITH SIMPLE STRING
//        let whatsNewController = WhatsNewController()
//                //insert customizations here
//        whatsNewController.appViewController = (self)
//        whatsNewController.alertMessage = "-Pugs with three legs now have expected fourth leg.\n-When repositioning collar, Pug's head no longer separates from body.\n-Pugs no longer deficate whenever they bark."
//        whatsNewController.displayFromStringIfNecessary()
       
        
        
        //EXAMPLE WITH SIMPLE STRING AND CUSTOMIZATION
        //        let whatsNewController = WhatsNewController()
        //        whatsNewController.alertOk = "Sounds good."
        //        whatsNewController.alertUpdatedToVersion = "Presenting Version "
        //        whatsNewController.showOnFirstLaunch = true
        //        whatsNewController.firstRunOk = "Sounds good."
        //        whatsNewController.firstRunTitle = "Welcome to Happy Pugs!"
        //        whatsNewController.firstRunMessage = "Hey, thanks for trying out Happy Pugs!"
        //        whatsNewController.appViewController = (self)
        //        whatsNewController.alertMessage = "-Pugs with three legs now have expected fourth leg.\n-When repositioning collar, Pug's head no longer separates from body.\n-Pugs no longer deficate whenever they bark."
        //        whatsNewController.displayFromStringIfNecessary()

        

    
        
        //-----EXAMPLE WITH URL
        let whatsNewController = WhatsNewController()
        //insert customizations here
        whatsNewController.appViewController = (self)
        whatsNewController.alertPageURL = NSURL(string: "https://en.wikipedia.org/wiki/Pug") //edit url
        whatsNewController.displayFromURLIfNeccessaryInsideApp(true) //edit true or false
        
        
        
        
        //-----EXAMPLE WITH URL AND CUSTOMIZATIONS
//        let whatsNewController = WhatsNewController()
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
//        whatsNewController.appViewController = (self)
//        whatsNewController.alertPageURL = NSURL(string: "https://en.wikipedia.org/wiki/Pug") //edit url
//        whatsNewController.displayFromURLIfNeccessaryInsideApp(true) //edit true or false
        

        
        

    }
}

