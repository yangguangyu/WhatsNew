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
     var infoPageURL: NSURL?
     var infoString: NSString?
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
     func displayFromHTMLIfNecessary (presentingViewController: UIViewController, embedded: Bool) {
        if UIApplication.isNewVersion {
            let currentAppVersion: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
            presentHTMLAlertOptions("\(currentAppVersion)", viewController: presentingViewController, embedded:embedded)
        }
    }


    
    
     func displayFromStringIfNecessary (presentingViewController: UIViewController) {
          if UIApplication.isNewVersion {
            let currentAppVersion: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
            presentStringAlert("\(currentAppVersion)", viewController: presentingViewController)
        }
    }
    
    //MARK: Prepare Alerts
     func presentHTMLAlertOptions (num: Version, viewController: UIViewController, embedded:Bool) {
        let alertController = UIAlertController(title: "Updated to Version \(num)", message: "Would you like to see what's new?", preferredStyle: .Alert)
        let OKAction: UIAlertAction = UIAlertAction (title: "OK", style: .Default) { action -> Void in
            self.showWebPage(embedded)
            UIApplication.persistVersion()
        }
        alertController.addAction(OKAction)
        let NOKAction: UIAlertAction = UIAlertAction (title: "No Thanks", style: .Default) { action -> Void in
            UIApplication.persistVersion()
        }
        alertController.addAction(NOKAction)
        viewController.presentViewController(alertController, animated: true) {
        }
    }
     func presentStringAlert (num: Version, viewController: UIViewController) {
        if (infoString == nil) {
            infoString = "" // formats text so developers can still show new version, sans details.
        }
        let alertController = UIAlertController (title: "Updated to Version \(num)", message: "\(infoString!)", preferredStyle: .Alert) //optional looked weird in popup, so !
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            UIApplication.persistVersion()
        }
        alertController.addAction(OKAction)
        viewController.presentViewController(alertController, animated: true) {
        }
    }
    
    //MARK: Load and Navigate Webpage
    func loadWebContent() {
        let request = NSURLRequest (URL: infoPageURL!)
        whatsNewWebView?.loadRequest(request)
    }
     func showWebPage (embedded: Bool) {
        if embedded {
            changeViewToWhatsNewHTML()
        } else {
            UIApplication.sharedApplication().openURL(infoPageURL!)
        }
    }
     func changeViewToWhatsNewHTML() {
        let storyBoard = UIStoryboard(name: "WhatsNew", bundle:nil)
        let whatsNewViewController = storyBoard.instantiateViewControllerWithIdentifier("WhatsNewViewController") as! WhatsNewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        UIView.transitionWithView(appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { appDelegate.window?.rootViewController = whatsNewViewController}, completion: nil)
        
        
    }
     func changeViewBackToRootView() {
        let initialViewController = UIStoryboard(name: "WhatsNew", bundle:nil).instantiateInitialViewController() as! UIViewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        UIView.transitionWithView(appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { appDelegate.window?.rootViewController = initialViewController}, completion: nil)

    }
    
    //MARK: Button Mashing
    @IBAction func backHome (sender: UIButton) {
        changeViewBackToRootView()
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

extension UIApplication {
    
    static var currentVersion: Version {
        
        return NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! Version //TODO: ask if this is okay?
    }
   
    
    static var isNewVersion: Bool {
        var isNew: Bool = true
        if let lastKnownVersionData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
            if let lastKnownVersionObject: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionData) {
                if ("\(lastKnownVersionObject)" < currentVersion) {
                    isNew = true
                } else {
                    isNew = false }}}
        return isNew
    }
    
    static func persistVersion () {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(UIApplication.currentVersion), forKey: "WhatsNew_LastKnownVersion")
    }
}




//WhatsNewVersionCheck.checkVersionAgainstLastKnown()
//UIApplication.isNewVersion
//UIApplication.persistVersion("1.23")
//UIApplication.persistVersion()

//MARK: Version Checking

/*
struct WhatsNewVersionCheck  {
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
//static func saveLatestVersionData (ver: Version) {
//     NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(ver), forKey: "WhatsNew_LastKnownVersion")
// }
}

*/

/*
static var isNewVersionBREAK: Bool {

var displayWhatsNew: Bool
if let lastKnownVersionStored = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData { //stored value
let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionStored) as! Version
if (lastKnownVersion < currentVersion) {
displayWhatsNew = true
} else {
displayWhatsNew = false
}
} else {  //no stored value
displayWhatsNew = true
}
return displayWhatsNew
}
*/

