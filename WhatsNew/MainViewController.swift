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
        
//        //EITHER USE...
//        //-----Option to post alert via a NSURL
//        WhatsNewController.infoPageURL = NSURL(string: "http://infusionsoft.com")!
//        WhatsNewController.storyboardID = NSString(string: "WhatsNew")
//        WhatsNewController.displayFromHTMLIfNecessary(self, embedded:false)
//        //-----
        
        
        //OR USE...
        //-----Option to post alert via an NSString
        WhatsNewController.infoString = "-Improved Pug tail control. \n-Pugs no longer randomly pee. \n-Fixed bug where Pugs were chasing Siri."
        WhatsNewController.displayFromStringIfNecessary(self)
        //
        //-----
        
        
        
        //////INSTRUCTIONS/////////
        //1. If you have an app that needs an alert, bring WhatsNew files into your project.
        //2. Place the two lines of code above in the root view's 'viewWillAppear' section.
        //3. Use displayFromHTMLIfNecessary if you would like to reference a version reference webpage.
        //4. Use displayFromStringIfNecessary if you would like a simple popup that you can type out.
        //5. For displayFromHTMLIfNecessary you can either popup a Safari window with embedded:false or embed the webpage inside a viewController with embedded:true. Either option requires that you designate a infoPageURL which is the webpage with all of your version information. Also type the StoryboardID in the storyboardString section.
        //6. For displayFromStringIfNecessary you can format a string to display inside of a simple alert view. If you decide not to format a string to show what's new, it will simply alert the user that a new version was installed.
        //7. Alerts will only happen once each time a new version is released.
        
    }
}