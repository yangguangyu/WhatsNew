//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit


class WhatsNewViewController: UIViewController {
    
    static var infoPageURL: NSURL?
    
    static func displayIfNecessary(presentingViewController: UIViewController) {
        let whatsNewVC = WhatsNewViewController()
        
        
        
        /////whatsNewVC.showWhatsNewAlert(<#url: String#>, num: <#String#>, viewController: <#UIViewController#>)
    }

    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        let url = "www.somedataonline.com"
        
        checkVersionForWhatsNew(url)
        
    }

    
    func checkVersionForWhatsNew(url: String) { //Check the actual version of the app that is loaded on the device.
        
        
        let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
        
        NSLog("App version loaded is %@", currentAppVersion)
        
        if let lastKnownVersionData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
            
            let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionData) as! Version
            
            NSLog("Yes, there is a saved version and it is @%.",lastKnownVersion)
            
            if (lastKnownVersion < currentAppVersion) {
                
                NSLog("Hey, there may be a popup alert here")
               
//                showWhatsNewAlert(url,num: currentAppVersion)
                
            }
            
        } else {
            
            NSLog("No, we have no idea what the last known version was.")
            
            //So, show what's new if exists then save current version
            
//            showWhatsNewAlert(url,num: currentAppVersion)
            
        }
        
    }
    
    
    
    
    func saveLastKnownVersionData() {
        //NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(appVersion), forKey: "WhatsNew_LastKnownVersion")
    }

    
    
    
    
    
    
    
    
    func showWhatsNewAlert(url: String, num: String, viewController: UIViewController)  {
        
        let alertController = UIAlertController(title: "What's New:", message: "Version \(num) has new features would you like to see them?", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        
        let NOKAction = UIAlertAction(title: "No Thanks", style: .Default) { (action) in

        }
        
        
        viewController.presentViewController(alertController, animated: true) {
            
        }
        
        
        NSLog("SHOW ALERT")
        
        //CREATE an html file TO DO
        //load in the html file
        //show the html file
        //ADVANCED FEATURE //check if connected to the internet and show that html file
        //After user clicks okay then saveLastKnownVersionData
        
    }
    
    

    
    
}



