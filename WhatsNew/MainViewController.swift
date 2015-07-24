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
        whatsNewController.showOnFirstLaunch = true  //if this is not included it just skips and doesn't show anything
        whatsNewController.appViewController = (self)
        whatsNewController.infoPageURL = NSURL(string: "https://en.wikipedia.org/wiki/Pug") //edit url
        whatsNewController.displayFromURLIfNeccessaryInsideApp(true) //edit true or false

        
        // OR CHOOSE THIS
        //-----Option to post alert via an NSString
//
//        let whatsNewController = WhatsNewController()
//        whatsNewController.appViewController = (self)
//        whatsNewController.infoString = "-Pugs no longer deficate when barking.\n-Pugs with three legs now have expected fourth leg in appropriate place.\n-When repositioning collar, Pug's head no longer separates from body." //edit text
//        whatsNewController.displayFromStringIfNecessary()
//        whatsNewController.showOnFirstLaunch = true
        //TODO: if it's a first launch then do you want to show still, or do you want to show other information.  showOnFirstLaunch bool default to False. isFirstLaunch bool add to other page

    
        
        ///whatsNewController.homeButton //already exposed
        
        
        //TODO: remove these button colors in favor of exposing buttons as indicated above.
// (optional) USE THIS to customize your webview
//               whatsNewController.customButtonColor = UIColor.yellowColor()
//               whatsNewController.customBackgroundColor = UIColor.redColor()  //TODO:Remove this
        
        // (alternatively) If you don't want extra code, you can set the Tint Color of each button in the What's New view controller and the background color of the WhatsNewViewController view.
        
    }


}



