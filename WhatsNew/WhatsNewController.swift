//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit
typealias Version = String

class WhatsNewController: UIViewController {
    
    //MARK: Initialization
    static var infoPageURL: NSURL?
    static var infoString: NSString?
    static var storyboardFileName: NSString?
    @IBOutlet var whatsNewWebView: UIWebView?
    
    //MARK: View Dids
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebContent()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Display Alerts
    static func displayFromHTMLIfNecessary (presentingViewController: UIViewController, embedded: Bool) {
        var weShouldDisplayWhatsNew = WhatsNewVersionCheck.checkVersionAgainstLastKnown()
        if weShouldDisplayWhatsNew {
            let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
            presentHTMLAlertOptions(currentAppVersion, viewController: presentingViewController, embedded:embedded)
        }
    }
    static func displayFromStringIfNecessary (presentingViewController: UIViewController) {
        var weShouldDisplayWhatsNew = WhatsNewVersionCheck.checkVersionAgainstLastKnown()
        if weShouldDisplayWhatsNew {
            let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
            presentStringAlert(currentAppVersion, viewController: presentingViewController)
        }
    }
    
    //MARK: Prepare Alerts
    static func presentHTMLAlertOptions (num: Version, viewController: UIViewController, embedded:Bool) {
        let alertController = UIAlertController(title: "Updated to Version \(num)", message: "Would you like to see what's new?", preferredStyle: .Alert)
        let OKAction: UIAlertAction = UIAlertAction (title: "OK", style: .Default) { action -> Void in
            self.showWebPage(embedded)
            WhatsNewVersionCheck.saveLatestVersionData(num)
        }
        alertController.addAction(OKAction)
        let NOKAction: UIAlertAction = UIAlertAction (title: "No Thanks", style: .Default) { action -> Void in
            WhatsNewVersionCheck.saveLatestVersionData(num)
        }
        alertController.addAction(NOKAction)
        viewController.presentViewController(alertController, animated: true) {
        }
    }
    static func presentStringAlert (num: Version, viewController: UIViewController) {
        if (infoString == nil) {
            infoString = "" // formats text so developers can still show new version, sans details.
        }
        let alertController = UIAlertController (title: "Updated to Version \(num)", message: "\(infoString!)", preferredStyle: .Alert) //optional looked weird in popup, so !
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            WhatsNewVersionCheck.saveLatestVersionData(num)
        }
        alertController.addAction(OKAction)
        viewController.presentViewController(alertController, animated: true) {
        }
    }
    
    //MARK: Load and Navigate Webpage
    func loadWebContent() {
        let request = NSURLRequest (URL: WhatsNewController.infoPageURL!)
        whatsNewWebView?.loadRequest(request)
    }
    static func showWebPage (embedded: Bool) {
        if embedded {
            changeViewToWhatsNewHTML()
        } else {
            UIApplication.sharedApplication().openURL(infoPageURL!)
        }
    }
    static func changeViewToWhatsNewHTML() {
        let storyName = storyboardFileName as! String
        let newStuff = UIStoryboard(name: storyName, bundle:nil).instantiateViewControllerWithIdentifier("WhatsNewViewController") as! UIViewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        UIView.transitionWithView(appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { appDelegate.window?.rootViewController = newStuff}, completion: nil)
        
        
    }
    static func changeViewBackToRootView() {
        let storyName = storyboardFileName as! String
        let initialViewController = UIStoryboard(name: storyName, bundle:nil).instantiateInitialViewController() as! UIViewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        UIView.transitionWithView(appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { appDelegate.window?.rootViewController = initialViewController}, completion: nil)

    }
    
    //MARK: Button Mashing
    @IBAction func backHome (sender: UIButton) {
        WhatsNewController.changeViewBackToRootView()
    }
    @IBAction func doRefresh(AnyObject) {
        whatsNewWebView?.reload()
    }
    @IBAction func goBack(AnyObject) {
        whatsNewWebView?.goBack()
    }
    @IBAction func goForward(AnyObject) {
        whatsNewWebView?.goForward()
    }
}

//MARK: Version Checking
class WhatsNewVersionCheck  {
    static func checkVersionAgainstLastKnown() -> Bool   {
        var displayWhatsNew: Bool
        let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
        if let lastKnownVersionStored = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData { //stored value
            let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionStored) as! Version
            if (lastKnownVersion < currentAppVersion) {
                displayWhatsNew = true
            } else {
                displayWhatsNew = false
            }
        } else {  //no stored value
            displayWhatsNew = true
        }
        return displayWhatsNew
    }
    static func saveLatestVersionData (ver: Version) {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(ver), forKey: "WhatsNew_LastKnownVersion")
    }
}






