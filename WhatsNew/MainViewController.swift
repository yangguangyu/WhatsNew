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
        

        
        //---------THIS----------
        
        
        //-----CHOOSE THIS
        //-----Option to post alert via a NSURL
        
        // (required 1)
        let whatsNewController = WhatsNewController()
        
        //(optional)
//        whatsNewController.alertOk = "Yep"
//        whatsNewController.alertNoThanks = "Nope"
//        whatsNewController.alertUpdatedToVersion = "Presenting Version "
//        whatsNewController.alertWouldYouLikeToSeeWhatsNew = "Want to see what is new?"
//        whatsNewController.showOnFirstLaunch = true
//        whatsNewController.firstRunOk = "Sounds good."
//        whatsNewController.firstRunTitle = "Welcome to Happy Pugs!"
//        whatsNewController.firstRunMessage = "Hey, thanks for trying out Happy Pugs!"
//        whatsNewController.customModalTransition = UIModalTransitionStyle.PartialCurl
        whatsNewController.customButtonColor = UIColor.yellowColor()
        whatsNewController.customBackgroundColor = UIColor.redColor()
        
        //(required 2)
        whatsNewController.appViewController = (self)
        whatsNewController.alertPageURL = NSURL(string: "https://en.wikipedia.org/wiki/Pug") //edit url
        whatsNewController.displayFromURLIfNeccessaryInsideApp(true) //edit true or false
        
        
        

        //---------OR THIS----------
       
        
        //-----OR CHOOSE THIS
        //-----Option to post alert via an NSString
        
        //(required 1)
//        let whatsNewController = WhatsNewController()
//        
        //(optional)
//        whatsNewController.alertOk = "Sounds good."
//        whatsNewController.alertUpdatedToVersion = "Presenting Version "
//        whatsNewController.showOnFirstLaunch = true
//        
        //(required 2)
//        whatsNewController.appViewController = (self)
//        whatsNewController.alertMessage = "-Pugs no longer deficate when barking.\n-Pugs with three legs now have expected fourth leg in appropriate place.\n-When repositioning collar, Pug's head no longer separates from body."
//        whatsNewController.displayFromStringIfNecessary()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //FIXME: Direct access of buttons causing fatal error
        //Customizing the buttons directly VS using a global color scheme//
        //Since these buttons might not exist when this page is called how would we access them to change their color?  Perhaps revert to setting a colorState, and assiging that color to all of the buttons
        //whatsNewController.homeButton.setTitleColor(UIColor .redColor(), forState: UIControlState.Normal)
        
        
    }


}



