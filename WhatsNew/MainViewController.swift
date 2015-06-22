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
        

        
        //EITHER USE...
        
        //-----Option to post alert via a NSURL
        WhatsNewController.infoPageURL = NSURL(string: "http://infusionsoft.com")!
        WhatsNewController.storyboardString = NSString(string: "Main")
        WhatsNewController.displayFromHTMLIfNecessary(self, embedded:true)
        //-----
        
        
        
        //OR USE...
        
//        //-----Option to post alert via an NSString
//        WhatsNewController.infoString = "-Improved Pug tail control. \n-Pugs no longer randomly pee. \n-Fixed bug where Pugs were chasing Siri."
//        WhatsNewController.displayFromStringIfNecessary(self)
//        //
//        //-----
        
        //BUT NOT BOTH
        
        
        
        
        //////INSTRUCTIONS/////////
        //1. If you have an app that needs an alert, paste WhatsNew into your project.
        //2. Place the two lines of code above in the root view's 'viewWillAppear' section.
        //3. Use displayFromHTMLIfNecessary if you would like to reference a webpage.
        //4. Use displayFromStringIfNecessary if you would like a simple popup.
        //5. For displayFromHTMLIfNecessary you can either popup a Safari window with embed:false or embed the webpage inside a viewController with embed:true. Either option requires that you designate a infoPageURL which is the webpage with all of your version information. Then type the StoryboardID in the storyboardString section.
        //6. For displayFromStringIfNecessary you can format a string to display inside of a simple alert view. If you decide not to format a string to show what's new, it will simply alert the user that a new version was installed.
        //7. Alerts will only happen once each time a new version is released.
        
    
        
        
    }
}