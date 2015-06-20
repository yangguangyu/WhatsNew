//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit
typealias Version = String




// TODO: Learn how to do TODO.
// FIXME: This fix me needs fixin'





// MARK: WhatsNew Setup

class WhatsNewController: UIViewController {
    
    
    static var infoPageURL: NSURL?
    static var infoString: NSString!
    @IBOutlet weak var whatsNewWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: Check version
    
    
    static func checkVersionAgainstLastKnown() ->Bool   { //Check the actual version of the app that is loaded on the device.
        
        var displayWhatsNew: Bool
        
        let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
        
        if let lastKnownVersionData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData
            
        {
            
            let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionData) as! Version
            
            println("Last known version was \(lastKnownVersion).")
            
            if (lastKnownVersion < currentAppVersion) {
                
                println("Cool, you have a new version!")
                
                displayWhatsNew = true
                
            } else {
                
                println("No, it's not a new version.")
                
                displayWhatsNew = false
                
            }
            
        } else {
            
            println("No idea what the last known version was, so show the alert.")
            
            displayWhatsNew = true
            
            
        }
        
        return displayWhatsNew
    }
    
    
    // MARK: Alert actions
    
    
    static func showWhatsNewFromHTMLAlert (num: Version, viewController: UIViewController, embedded:Bool)  {
        let whatsNewVC = WhatsNewController()
        
        let alertController = UIAlertController(title: "Updated to Version \(num)", message: "Would you like to see what is new in version \(num)?", preferredStyle: .Alert)
        
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            self.showWebPage(embedded) //Show the webpage
            ///////UNCOMMENT AFTER TESTS COMPLETE **** whatsNewVC.saveLatestVersionData(num)
            
        }
        
        alertController.addAction(OKAction)
        
        let NOKAction: UIAlertAction = UIAlertAction(title: "No Thanks", style: .Default) { action -> Void in

            self.saveLatestVersionData(num)
            
        }
        
        alertController.addAction(NOKAction)
        
        viewController.presentViewController(alertController, animated: true) {
            println("SHOW ALERT")
            
        }
        
        
        
    }
    
    
    
    
    static func showWhatsNewFromStringAlert(num: Version, viewController: UIViewController)  {
        let whatsNewVC = WhatsNewController()
        
        //// this helps format the string in case they decide not to include a string to display, but developer still wants to show the updated version number.
        
        if (infoString == nil) { //TODO: maybe improve?
            infoString = ""
        }
        
        /////
        
        
        
        let alertController = UIAlertController(title: "Updated to Version \(num)", message: "\(infoString)", preferredStyle: .Alert)
        
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            self.saveLatestVersionData(num)
        }
        
        
        alertController.addAction(OKAction)
        
        viewController.presentViewController(alertController, animated: true) {
            println("SHOW ALERT")
            
        }
        
        
        
    }
    
    
    
    // MARK: Display whats new
    
    static func displayFromHTMLIfNecessary(presentingViewController: UIViewController, embedded: Bool) {
        //let whatsNewVC = WhatsNewController()
        
        
        
        println("Attempting to display html version of what's new.")
        
        var weShouldDisplayWhatsNew = checkVersionAgainstLastKnown()
        
        if weShouldDisplayWhatsNew {
            
            let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version //declared twice?
            
            showWhatsNewFromHTMLAlert(currentAppVersion, viewController: presentingViewController, embedded:embedded)
            
        }
        
        
    }
    
    
    
    static func displayFromStringIfNecessary(presentingViewController: UIViewController) {
        
        println("display what's new from String")
        
        var weShouldDisplayWhatsNew = checkVersionAgainstLastKnown()
        
        
        if weShouldDisplayWhatsNew {
            
            let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version //declared twice?
            
            showWhatsNewFromStringAlert(currentAppVersion, viewController: presentingViewController)
            
        }
        
    }
    
    
    

    
    
    // MARK: Show webpage
    
    
    
    static func showWebPage(embedded: Bool) {
        
        
        if embedded {
            println("Bing, a webpage is embedded.")
            
        } else {
            println("Bing, a webpage pops up.")
            UIApplication.sharedApplication().openURL(infoPageURL!)
    
        }
    }
    
    static func saveLatestVersionData(ver: Version) {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(ver), forKey: "WhatsNew_LastKnownVersion")
        
        println("Saving last known version to disk")
        
    }
    
    // Go back to home page
    @IBAction func backToApp(sender: UIButton) {
     
        println("Click back to app!")
        
        loadWebContent()
        
    }
    
     func loadWebContent() {
        
        println("Load in that web page..")
        
        let url = NSURL(string: "http://www.infusionsoft.com")
        let request = NSURLRequest(URL: url!)
        whatsNewWebView.loadRequest(request)
        
    }
    
    @IBAction func doRefresh(AnyObject) {
        whatsNewWebView.reload()
    }
    
    @IBAction func goBack(AnyObject) {
        whatsNewWebView.goBack()
    }
    
    @IBAction func goForward(AnyObject) {
        whatsNewWebView.goForward()
    }
    
    @IBAction func stop(AnyObject) {
        whatsNewWebView.stopLoading()
    }
    
    
}
    





