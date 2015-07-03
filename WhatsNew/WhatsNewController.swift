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
    
    //MARK: View Dids
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebContent()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Simple String Alert
    func displayFromStringIfNecessary () { //format based on version and whether or not string present
        if UIApplication.isNewVersion {
            if let formattedString = infoString {
                stringAlert(formattedString)
            } else { //no custom text
                stringAlert("")
            }
        }
    }
    func stringAlert(messageText: NSString) { //show what's new string
        let alertController = UIAlertController (title: "Updated to Version \(UIApplication.currentVersion)", message: "\(messageText)", preferredStyle: .Alert)
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            UIApplication.persistVersion()
        }
        alertController.addAction(OKAction)
        if let viewConfirmed = appViewController {
            viewConfirmed.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: HTML/WebView Alerts
    func displayFromHTMLIfNecessary (#embedded:Bool) {  //prepare popup with yes no option to view webpage alert
        if UIApplication.isNewVersion {
            let alertController = UIAlertController(title: "Updated to Version \(UIApplication.currentVersion)", message: "Would you like to see what's new?", preferredStyle: .Alert)
            let OKAction: UIAlertAction = UIAlertAction (title: "OK", style: .Default) { action -> Void in
                self.showWebPage(embedded:true) //show webpage
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
    func showWebPage (#embedded:Bool) { //show what's new webpage, either in safari or embedded webview
        if embedded {
            if let viewConfirmed = appViewController {
                var sb = UIStoryboard(name: "WhatsNew", bundle: nil)
                
                if let vc = sb.instantiateViewControllerWithIdentifier("WhatsNewViewController") as? WhatsNewController {
                    vc.infoPageURL = infoPageURL //pass the nsurl to new view
                    vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical //change page flip animation as desired
                    viewConfirmed.presentViewController(vc, animated: true, completion: nil)
                } else {
                    println("derp. no storyboard content")
                }
            }
        } else {
            if let urlConfirmed = infoPageURL {
                UIApplication.sharedApplication().openURL(urlConfirmed)
            }
        }
    }
    func loadWebContent() { //reload webpage
        if let urlConfirmed = infoPageURL {
            let request = NSURLRequest (URL: urlConfirmed)
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
        var isNew: Bool = true
        if let lastKnownVersionData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
            if let lastKnownVersionObject: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionData) {
                if ("\(lastKnownVersionObject)" < currentVersion) {
                    isNew = true
                } else {
                    isNew = false
                }
            }
        }
        return isNew
    }

    static func persistVersion () { //store current version
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(UIApplication.currentVersion), forKey: "WhatsNew_LastKnownVersion")
    }
}

