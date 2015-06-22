//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//
// TODO: Learn how to do TODO.
// FIXME: This fix me needs fixin'


// MARK: Import and initialization

import UIKit
typealias Version = String



// MARK: WhatsNew Setup

class WhatsNewController: UIViewController {
    
    
    static var infoPageURL: NSURL?
    static var infoString: NSString?
    @IBOutlet var newWebView: UIWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadWebContent()

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
            self.saveLatestVersionData(num)
            
        }
        
        alertController.addAction(OKAction)
        
        let NOKAction: UIAlertAction = UIAlertAction(title: "No Thanks", style: .Default) { action -> Void in

            self.saveLatestVersionData(num)
            
        }
        
        alertController.addAction(NOKAction)
        
        viewController.presentViewController(alertController, animated: true) {
            println("Showing alert.")
            
        }
        
        
        
    }
    
    
    
    
    static func showWhatsNewFromStringAlert(num: Version, viewController: UIViewController)  {
        let whatsNewVC = WhatsNewController()
        
        //// this helps format the text in case they decide not to include a string to display, but developer still wants to show the updated version number.
        
        if (infoString == nil) {
            infoString = ""
        }
        
        let alertController = UIAlertController(title: "Updated to Version \(num)", message: "\(infoString!)", preferredStyle: .Alert) //optional looked weird in popup alert
        
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
    let whatsNewVC = WhatsNewController()

        if embedded {
            println("Bing, a webpage is embedded.")
            whatsNewVC.changeViewToWhatsNewHTML()
            
        } else {
            println("Bing, a webpage pops up.")
            UIApplication.sharedApplication().openURL(infoPageURL!)
    
        }
    }
    
    static func saveLatestVersionData(ver: Version) {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(ver), forKey: "WhatsNew_LastKnownVersion")
        
        println("Saving last known version to disk")
        
    }
    
    
    func loadWebContent() {

        println("Attempting to load your web page..")
        
        let url = NSURL(string: "http://www.infusionsoft.com")
        
        let request = NSURLRequest(URL: url!)
    
        newWebView?.loadRequest(request)
        
    }
    
    
    
    func changeViewToWhatsNewHTML() {
        //FIXME: WORKS BUT what happens if their storyboard isn't called Main?
        let newStuff = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("WhatsNewViewController") as! UIViewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.window?.rootViewController = newStuff
        
    }
    
    
    @IBAction func backToApp(sender: UIButton) {
        //FIXME: WORKS BUT what happens if their storyboard isn't called Main?
        let initialViewController = UIStoryboard(name: "Main", bundle:nil).instantiateInitialViewController() as! UIViewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.window?.rootViewController = initialViewController
        
    }
    
    @IBAction func doRefresh(AnyObject) {
        newWebView?.reload()
        
    }
    
    @IBAction func goBack(AnyObject) {
        newWebView?.goBack()
    }
    
    @IBAction func goForward(AnyObject) {
        newWebView?.goForward()
    }
    
    @IBAction func stop(AnyObject) {
        newWebView?.stopLoading()
    }
    
    
}
    





