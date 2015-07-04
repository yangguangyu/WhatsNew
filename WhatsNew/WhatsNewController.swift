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
    var appViewController: UIViewController?
    @IBOutlet var whatsNewWebView: UIWebView?
    
    //MARK: ViewDids
    override func viewDidLoad() {
        super.viewDidLoad()
        beautify()
        loadWebContent()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    
    //MARK: Simple String Alert
    func displayFromStringIfNecessary () { //what's new alert based on simple string
        if UIApplication.isNewVersion {
            if let confirmedString = infoString {
                showString(confirmedString)
            } else {
                showString("")
            }
        }
    }
    func showString(messageText: NSString) { //show string
        let alertController = UIAlertController (title: "Updated to Version \(UIApplication.currentVersion)", message: "\(messageText)", preferredStyle: .Alert)
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            UIApplication.persistVersion()
        }
        alertController.addAction(OKAction)
        if let confirmedView = appViewController {
            confirmedView.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: HTML/WebView Alerts
    func displayFromHTMLIfNecessary (#embedded:Bool) {  //what's new alert based on custom url
        if UIApplication.isNewVersion {
            let alertController = UIAlertController(title: "Updated to Version \(UIApplication.currentVersion)", message: "Would you like to see what's new?", preferredStyle: .Alert)
            let OKAction: UIAlertAction = UIAlertAction (title: "OK", style: .Default) { action -> Void in
                self.showWebPage(embedded:embedded)
                UIApplication.persistVersion()
            }
            alertController.addAction(OKAction)
            let NOKAction: UIAlertAction = UIAlertAction (title: "No Thanks", style: .Default) { action -> Void in
                UIApplication.persistVersion()
            }
            alertController.addAction(NOKAction)
            if let viewConfirmed = appViewController {
                viewConfirmed.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    func beautify(){
        view.backgroundColor = UIColor.darkGrayColor() //set to custom desired colors 
        //TODO: add text uicolors as well?
    }
    func showWebPage (#embedded:Bool) { //show webpage
        if embedded {
            if let viewConfirmed = appViewController {
                var sb = UIStoryboard(name: "WhatsNew", bundle: nil)
                if let vc = sb.instantiateViewControllerWithIdentifier("WhatsNewViewController") as? WhatsNewController {
                    vc.infoPageURL = infoPageURL //pass the nsurl to the new view
                    vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal //change page flip animation as desired
                    viewConfirmed.presentViewController(vc, animated: true, completion: nil)
                }
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
    @IBAction func backHome (sender: UIButton) {self.dismissViewControllerAnimated(true, completion: nil)}
    @IBAction func doRefresh(AnyObject) {whatsNewWebView?.reload()}
    @IBAction func goBack(AnyObject) {whatsNewWebView?.goBack()}
    @IBAction func goForward(AnyObject) {whatsNewWebView?.goForward()}
    
}

//MARK: UIApplication extensions
extension UIApplication {
    static var currentVersion: Version { //check current version
        if let confirmedVersion : Version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? Version {
            return confirmedVersion
        } else {
            return "0.0"
        }
    }
    static var isNewVersion: Bool { //check if it's a new version
        var new: Bool = true
        if let userData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
            if let lastKnownVersion: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithData(userData) {
                if ("\(lastKnownVersion)" < currentVersion) {
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
