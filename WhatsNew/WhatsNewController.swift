//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//
// TODO: Learn how to do TODO.
// FIXME: This FIXME me needs fixin'


import UIKit
typealias Version = String



// MARK: WhatsNew Setup

class WhatsNewController: UIViewController {
    
    
    static var infoPageURL: NSURL?
    static var infoString: NSString?
    static var storyboardString: NSString?
    
    @IBOutlet var newWebView: UIWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebContent()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Alert actions
    
    static func showWhatsNewFromHTMLAlert (num: Version, viewController: UIViewController, embedded:Bool)  {
        let whatsNewVC = WhatsNewController()
        
        let alertController = UIAlertController(title: "Updated to Version \(num)", message: "Would you like to see whats new?", preferredStyle: .Alert)
        
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            self.showWebPage(embedded)
            self.saveLatestVersionData(num)
            
        }
        
        alertController.addAction(OKAction)
        
        let NOKAction: UIAlertAction = UIAlertAction(title: "No Thanks", style: .Default) { action -> Void in

            self.saveLatestVersionData(num)
            
        }
        
        alertController.addAction(NOKAction)
        
        viewController.presentViewController(alertController, animated: true) {
            
        }
        
        
        
    }
    
    
    
    
    static func showWhatsNewFromStringAlert(num: Version, viewController: UIViewController)  {
        let whatsNewVC = WhatsNewController()
        
      
        
        if (infoString == nil) {  //// this helps format the text in case they decide not to include a string to display, but developer still wants to show the updated version number.
            infoString = ""
        }
        
        let alertController = UIAlertController(title: "Updated to Version \(num)", message: "\(infoString!)", preferredStyle: .Alert) //optional looked weird in popup alert, so since it can't be nil made it !
        
        let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            self.saveLatestVersionData(num)
        }
        
        alertController.addAction(OKAction)
        
        viewController.presentViewController(alertController, animated: true) {
            
        }
        
    }
    
    
    
    // MARK: Display whats new
    
    static func displayFromHTMLIfNecessary(presentingViewController: UIViewController, embedded: Bool) {
        
        var weShouldDisplayWhatsNew = WhatsNewVersionCheck.checkVersionAgainstLastKnown()
        
        if weShouldDisplayWhatsNew {
            
            let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
            
            showWhatsNewFromHTMLAlert(currentAppVersion, viewController: presentingViewController, embedded:embedded)
            
        }
        
        
    }
    
    
    
    static func displayFromStringIfNecessary(presentingViewController: UIViewController) {
        
        var weShouldDisplayWhatsNew = WhatsNewVersionCheck.checkVersionAgainstLastKnown()
        
        if weShouldDisplayWhatsNew {
            
            let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
            
            showWhatsNewFromStringAlert(currentAppVersion, viewController: presentingViewController)
            
        }
        
    }
    
    
    

    
    
    // MARK: Show webpage
    
    static func showWebPage(embedded: Bool) {

        if embedded {
            changeViewToWhatsNewHTML()
            
        } else {
            UIApplication.sharedApplication().openURL(infoPageURL!)
    
        }
    }
    
    static func saveLatestVersionData(ver: Version) {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(ver), forKey: "WhatsNew_LastKnownVersion")
        
    }
    
    
    func loadWebContent() {
        
        let request = NSURLRequest(URL: WhatsNewController.infoPageURL!)
        
         newWebView?.loadRequest(request)
    }
    
    
    
    static func changeViewToWhatsNewHTML() {
        let storyString = self.storyboardString as! String
        let newStuff = UIStoryboard(name: storyString, bundle:nil).instantiateViewControllerWithIdentifier("WhatsNewViewController") as! UIViewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.window?.rootViewController = newStuff
        
    }
    
    static func changeViewBackToRootView() {
        let storyString = storyboardString as! String
        let initialViewController = UIStoryboard(name: storyString, bundle:nil).instantiateInitialViewController() as! UIViewController
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.window?.rootViewController = initialViewController
        
    }
    
    
    //MARK: Button mash section
    
    @IBAction func backButtonAction(sender: UIButton){
        WhatsNewController.changeViewBackToRootView()
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
    
//    @IBAction func stop(AnyObject) {
//        newWebView?.stopLoading()
//    }
    
    
}
    





