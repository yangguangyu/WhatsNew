//
//  ViewController.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit

class WhatsNewController: UIViewController {
    
    //MARK: Initialization
    var appViewController: UIViewController?
    var showOnFirstLaunch = false
    
    //TODO: Expose the following
    var alertPageURL: NSURL?
    var alertMessage = ""
    var alertOk = "OK"
    var alertNoThanks = "No Thanks"
    var alertUpdatedToVersion = "Updated to Version \(UIApplication.currentVersion.string)"
    var alertWouldYouLikeToSeeWhatsNew = "Would you like to see what's new?"
    var firstRunOk = "OK"
    var firstRunTitle = "Thanks!"
    var firstRunMessage = "If you have any questions check out our info page."


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
    */
    
    func displayFromStringIfNecessary () { //begin what's new alert based on simple string
        
        if UIApplication.isFirstRun && showOnFirstLaunch {  //if this is the first run..
            
            firstRunAlert()
    
        } else if UIApplication.isUpdatedVersion {
            
            let alertController = UIAlertController (title: alertUpdatedToVersion, message: alertMessage, preferredStyle: .Alert)
       
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
    
    :param: displayInsideApp This Bool designates whether you would prefer the URL to open embedded within the application, never leaving it, or whether you would prefer the URL to open up in an external browser.
    */
    
    func displayFromURLIfNeccessaryInsideApp (displayInsideApp: Bool) {  //begin what's new alert based on custom url
        
        if UIApplication.isFirstRun && showOnFirstLaunch { //if you want to show something cool..
            
            firstRunAlert()
            
        } else if UIApplication.isUpdatedVersion { //if this is not a first run check if it's an updated version..
            
            let alertController = UIAlertController(title: alertUpdatedToVersion, message: alertWouldYouLikeToSeeWhatsNew, preferredStyle: .Alert) //TODO: Move strings to user accessable
            
            let okAction: UIAlertAction = UIAlertAction (title: alertOk, style: .Default) { action -> Void in
                
                self.showWebPage(displayInsideApp)  //rename if needed  (openinsafari)
                
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
    
    //TODO: Combine into one alert?
    func showAlert (title: String)(message: String)(ok: String)(cancel: String) {
    }
    
    //TODO: phase out?
    func beautify(){  //change colors to match your app
        
        
        if let confirmedBGColor = customBackgroundColor{ //nil by default is black and I want grey 
        view.backgroundColor = customBackgroundColor
        }
        
        homeButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        backButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        forwardButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
        reloadButton.setTitleColor(customButtonColor, forState: UIControlState.Normal)
    }
    
    
    func showWebPage (displayInsideApp:Bool) { //actually show webpage
        if displayInsideApp {
            
            let sb = UIStoryboard(name: "WhatsNew", bundle: nil)
            if let viewConfirmed = appViewController, //MARK this is cool. Here we have combined multiple if let statements
                vc = sb.instantiateViewControllerWithIdentifier("WhatsNewViewController") as? WhatsNewController {
                    
                    vc.alertPageURL = alertPageURL //pass nsurl to new view
                    vc.customButtonColor = customButtonColor //pass to new view
                    vc.customBackgroundColor = customBackgroundColor //pass to new view
                    vc.modalTransitionStyle = UIModalTransitionStyle.CoverVertical //change page flip animation as desired
                    
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






