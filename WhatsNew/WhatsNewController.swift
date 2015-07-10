//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit
public typealias Version = String

class WhatsNewController: UIViewController {
    
    //MARK: Initialization
    var infoPageURL: NSURL?
    var infoString: NSString = "" //TODO cleanup this
    var appViewController: UIViewController?
    var customButtonColor: UIColor?
    var customBackgroundColor: UIColor?

    //MARK: Outlets
    @IBOutlet var whatsNewWebView: UIWebView!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var reloadButton: UIButton!
    
    //MARK: ViewDids
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beautify() //change colors of webview buttons and background
        loadWebContent() //load webpage
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: Simple String Alert
    func displayFromStringIfNecessary () { //begin what's new alert based on simple string
        if UIApplication.isNewVersion {
                showString(infoString)
        }
    }
    func showString(messageText: NSString) { //actually show string
        let alertController = UIAlertController (title: "Updated to Version \(UIApplication.currentVersion)", message: "\(messageText)", preferredStyle: .Alert)
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            UIApplication.persistVersion()
        }
        alertController.addAction(OKAction)
        if let confirmedView = appViewController {
            confirmedView.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: Web View Alerts
    //TODO:Create more of these sweet things
    /**
    What does this thing do.
    
    :param: embedded What does embedded mean.
    */
    
    func displayFromURLIfNecessary (#embedded:Bool) {  //begin what's new alert based on custom url
        if UIApplication.isNewVersion { //TODO: remove pounds
            let alertController = UIAlertController(title: "Updated to Version \(UIApplication.currentVersion)", message: "Would you like to see what's new?", preferredStyle: .Alert)
            let okAction: UIAlertAction = UIAlertAction (title: "OK", style: .Default) { action -> Void in
                self.showWebPage(embedded:embedded)  //rename if needed  (openinsafari)
                UIApplication.persistVersion()
            }
            alertController.addAction(okAction)
            let nokAction: UIAlertAction = UIAlertAction (title: "No Thanks", style: .Default) { action -> Void in
                UIApplication.persistVersion()
            }
            alertController.addAction(nokAction)
            if let viewConfirmed = appViewController {
                viewConfirmed.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    func beautify(){  //change colors to match your app //TODO:  //titleColor as a Struct
        //TODO: Figure out what that Infusionsoft Grey color really is.
        
        if let confirmedBGColor = customBackgroundColor{ //nil by default is black and I want grey 
        view.backgroundColor = customBackgroundColor
        }
        
        homeButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        backButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        forwardButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        reloadButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
    }
    func showWebPage (#embedded:Bool) { //actually show webpage
        if embedded {
            
            let sb = UIStoryboard(name: "WhatsNew", bundle: nil)
            if let viewConfirmed = appViewController, //TODO this is cool. Here we have combined multiple if let statements
                vc = sb.instantiateViewControllerWithIdentifier("WhatsNewViewController") as? WhatsNewController {
                    
                    vc.infoPageURL = infoPageURL //pass nsurl to new view
                    vc.customButtonColor = customButtonColor //pass to new view
                    vc.customBackgroundColor = customBackgroundColor //pass to new view
                    vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical //change page flip animation as desired
                    
                    viewConfirmed.presentViewController(vc, animated: true, completion: nil)
            }
        } else {
            if let urlConfirmed = infoPageURL {
                UIApplication.sharedApplication().openURL(urlConfirmed)
            }
        }
    }
    func loadWebContent() { //reload webpage
        if let confirmedURL = infoPageURL {
            let request = NSURLRequest (URL: confirmedURL)
            whatsNewWebView?.loadRequest(request)
        }
    }
    
    //MARK: Button Mashing
    @IBAction func backHome (sender: UIButton){self.dismissViewControllerAnimated(true, completion: nil)}
    @IBAction func doRefresh(AnyObject) {whatsNewWebView?.reload()}
    @IBAction func goBack(AnyObject) {whatsNewWebView?.goBack()}
    @IBAction func goForward(AnyObject) {whatsNewWebView?.goForward()}
}

//MARK: UIApplication extensions
extension UIApplication {
 public static var currentVersion: Version {
        if let confirmedVersion : Version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? Version {
            return confirmedVersion
        } else {
            return "0.0" //maybe change to "unknown"
        }
    }
    
    //TODO: //mark all of my tests as public in swift See line 139
    
    
    //FIX 2.12.8 failed vs 2.2.0
    //Break apart and figure out which is higher..  IP Address comparison.  Versioning..
    
    
 public static var isNewVersion: Bool { //check if it's a new version
        var new: Bool = true
        if let userData = //TODO: wrap in if let ACtually combine all two iflets
            NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
            if let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(userData) as? String {
                if (lastKnownVersion < currentVersion) {
                    new = true
                } else {
                    new = false
                }
            }
        }
        return new
    }
    static func persistVersion () { //store current version
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(UIApplication.currentVersion), forKey: "WhatsNew_LastKnownVersion")
    }
}
