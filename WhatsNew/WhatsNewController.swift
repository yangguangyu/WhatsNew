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
    var appView: UIViewController?
    
    @IBOutlet var whatsNewWebView: UIWebView?
    
    //MARK: View Dids
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //MARK: Simple String Alert
    func displayFromStringIfNecessary () {
        if UIApplication.isNewVersion {
            presentStringAlert()
        }
    }
    
    
    func presentStringAlert () {
        
        if (infoString == nil) { //TODO: better way?
            infoString = "" // formats for version popup with no text, also see below so the popup alert doesn't say the word Optional in the text
        }
        
        let alertController = UIAlertController (title: "Updated to Version \(UIApplication.currentVersion)", message: "\(infoString!)", preferredStyle: .Alert) //optional looked weird in popup
        
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            UIApplication.persistVersion()
        }
        alertController.addAction(OKAction)
        
        if let viewConfirmed = appView {
            viewConfirmed.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    
    //MARK: HTML/WebView Alerts
    
    func displayFromHTMLIfNecessary (embedded:Bool) {
        if UIApplication.isNewVersion {
            
            let alertController = UIAlertController(title: "Updated to Version \(UIApplication.currentVersion)", message: "Would you like to see what's new?", preferredStyle: .Alert)
            
            
            let OKAction: UIAlertAction = UIAlertAction (title: "OK", style: .Default) { action -> Void in
                self.showWebPage(true)
                UIApplication.persistVersion()
            }
            alertController.addAction(OKAction)
            
            
            let NOKAction: UIAlertAction = UIAlertAction (title: "No Thanks", style: .Default) { action -> Void in
                UIApplication.persistVersion()
            }
            alertController.addAction(NOKAction)
            if let viewConfirmed = appView {
                viewConfirmed.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    
    func loadWebContent() {
        
        //REMOVE THIS AFTER TESTING...
        println("info page is \(infoPageURL) and appView is \(appView)")
        ///infoPageURL = NSURL(string: "http://infusionsoft.com") //customize url
        //
        if let urlConfirmed = infoPageURL {
            let request = NSURLRequest (URL: urlConfirmed)
            whatsNewWebView?.loadRequest(request)
        }
    }
    func showWebPage (embedded:Bool) {
        
        if embedded {
            if let viewConfirmed = appView {
                viewConfirmed.presentViewController(whatsNewView, animated: true, completion: nil) //FIXME: after this the strings are wiped
            }
        } else {
            if let urlConfirmed = infoPageURL {
                UIApplication.sharedApplication().openURL(urlConfirmed)
            }
        }
    }
    
    var whatsNewView: UIViewController {
        let storyBoard = UIStoryboard(name: "WhatsNew", bundle:nil)
        return storyBoard.instantiateViewControllerWithIdentifier("WhatsNewViewController") as! UIViewController //TODO: better way?
        
    }
    
    
    //MARK: Button Mashing
    @IBAction func backHome (sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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


//MARK: UIApplication extensions

extension UIApplication {
    
    static var currentVersion: Version {
        
        return NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! Version //TODO: better way?
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

