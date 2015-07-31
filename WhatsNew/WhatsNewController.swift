//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
////

import UIKit

class WhatsNewController: UIViewController {
    
    //MARK: Initialization
    var appViewController: UIViewController?
    var customButtonColor: UIColor?
    var customBackgroundColor: UIColor?
    var customModalTransition: UIModalTransitionStyle = .CoverVertical
    var showOnFirstLaunch = false
    var alertPageURL: NSURL?
    var alertMessage = ""
    var alertOk = NSLocalizedString("OK", comment: "Okay")
    var alertNoThanks = NSLocalizedString("No Thanks", comment: "No, thank you")
    var alertUpdatedToVersion = NSLocalizedString("Updated to Version ", comment: "Updated to Version ")
    var alertWouldYouLikeToSeeWhatsNew = NSLocalizedString("Would you like to see what's new?", comment:"Would you like to see what is new?")
    var firstRunOk = NSLocalizedString("OK", comment: "OK")
    var firstRunTitle = NSLocalizedString("Welcome", comment: "Welcome")
    var firstRunMessage = NSLocalizedString("If you have any questions check out our info page.", comment: "If you have any questions please see our info page.")


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

    /**
    Displays What's New information via a custom String if a new version is detected.

    :param: alertMessage This String contains the list of new features. If no String is detected, What's New just displays the new version number.
    
    :param: alertUpdatedToVersion This String is the top title line of the alert that is presented.
    
    :param: alertOk This String is the text inside the button to confirm and continue.
    
    :param: showOnFirstLaunch This Bool can be set to show a custom message the first time the application is launched.  The custom message can be altered using firstRunOk, firstRunTitle, and firstRunMessage. If bool is not set the default is false, and will not display anything at first launch.
    */
    
    func displayFromStringIfNecessary () { //begin what's new alert based on simple string
        
        if UIApplication.isFirstRun && showOnFirstLaunch { //if this is first app launch and you want to present alert
            
            firstRunAlert()
    
        } else if UIApplication.isUpdatedVersion { //else it's not the first run, let's check if it's updated since last launch
            
            let alertController = UIAlertController (title: alertUpdatedToVersion + UIApplication.currentVersion.string, message: alertMessage, preferredStyle: .Alert)
            
            let OKAction: UIAlertAction = UIAlertAction(title: alertOk, style: .Default) { action -> Void in
            
                UIApplication.persistVersion()
        
            }
            alertController.addAction(OKAction)
            
            if let confirmedView = appViewController {
            
                confirmedView.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    

    //MARK: Web View Alerts
    
    /**
    Displays What's New information via a custom URL if a new version is detected.
    
    :param: displayInsideApp This Bool designates whether you would prefer the URL to open embedded within the application, or whether you would prefer the URL to open up in an external browser.
    
    :param: alertWouldYouLikeToSeeWhatsNew This String is the message presented asking the user if they would like to see what's new and navigate to the URL web view.
    
    :param: alertUpdatedToVersion This String is the top title line of the alert that is presented.
    
    :param: alertOk This String is the text inside the button to confirm and continue.
    
    :param: alertNoThanks This String is the text inside the button that cancels without viewing what's new.
    
    :param: showOnFirstLaunch This Bool can be set to show a custom message the first time the application is launched.  The custom message can be altered using firstRunOk, firstRunTitle, and firstRunMessage. If bool is not set the default is false, and will not display anything at first launch.
    */
    
    func displayFromURLIfNeccessaryInsideApp (displayInsideApp: Bool) {  //begin what's new alert based on custom url
        
        if UIApplication.isFirstRun && showOnFirstLaunch { // if this is first time launching app and you want to present alert
            
            firstRunAlert()
            
        } else if UIApplication.isUpdatedVersion { // else, let's check if it's updated since last launch
            
            let alertController = UIAlertController(title: alertUpdatedToVersion + UIApplication.currentVersion.string, message: alertWouldYouLikeToSeeWhatsNew, preferredStyle: .Alert)
            
            let okAction: UIAlertAction = UIAlertAction (title: alertOk, style: .Default) { action -> Void in
                self.showWebPage(displayInsideApp)
                
                UIApplication.persistVersion()
            }
            
            alertController.addAction(okAction)
            
            let nokAction: UIAlertAction = UIAlertAction (title: alertNoThanks, style: .Default) { action -> Void in
                
                UIApplication.persistVersion()
            }
            
            alertController.addAction(nokAction)
            
            if let viewConfirmed = appViewController {
            
                viewConfirmed.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func firstRunAlert() {
        
        let alertController = UIAlertController (title: firstRunTitle, message: firstRunMessage, preferredStyle: .Alert)
        
        let OKAction: UIAlertAction = UIAlertAction(title: firstRunOk, style: .Default) { action -> Void in
            
            UIApplication.persistVersion() //TODO: redundant?
            
        }
        
        alertController.addAction(OKAction)
        
        if let confirmedView = appViewController {
            
            confirmedView.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    func beautify(){  //change colors to match your app
        
        if let confirmedBGColor = customBackgroundColor{
        
            view.backgroundColor = customBackgroundColor
            
        }
        
        homeButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        backButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        forwardButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        reloadButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
    }
    
    
    func showWebPage (displayInsideApp:Bool) {
        
        if displayInsideApp {
            
            let sb = UIStoryboard(name: "WhatsNew", bundle: nil)
            if let viewConfirmed = appViewController,
                vc = sb.instantiateViewControllerWithIdentifier("WhatsNewViewController") as? WhatsNewController {
                    
                    //passing to new view
                    vc.alertPageURL = alertPageURL
                    vc.customButtonColor = customButtonColor
                    vc.customBackgroundColor = customBackgroundColor
                    vc.modalTransitionStyle = customModalTransition
                    
                    viewConfirmed.presentViewController(vc, animated: true, completion: nil)
            }
            
        } else {
            
            if let urlConfirmed = alertPageURL {
                UIApplication.sharedApplication().openURL(urlConfirmed)
            }
        }
    }

    
    func loadWebContent() { //reload webpage
        if let confirmedURL = alertPageURL {
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






