//
//  VersionHelper.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import Foundation


typealias Version = String



func checkVersion(url: String) { //Check the actual version of the app that is loaded on the device.
    
    let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
    
    NSLog("App version loaded is %@", currentAppVersion)
    
    if let lastKnownVersionData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
        
        let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionData) as! Version
        
        NSLog("Yes, there is a saved version and it is @%.",lastKnownVersion)
        
        if (lastKnownVersion < currentAppVersion) {
            
            NSLog("Hey, there may be a popup alert here")
            
            showWhatsNewAlert()
            
        }
        
    } else {
        
        NSLog("No, we have no idea what the last known version was.")
        
        //So, show what's new if exists then save current version
        
        showWhatsNewAlert()
        
    }
    
}




func showWhatsNewAlert() {
    
    
    
    NSLog("SHOW ALERT")
    
    
    //load in the html file
    //show the html file
    //ADVANCED FEATURE //check if connected to the internet and show that html file
    //After user clicks okay then saveLastKnownVersionData
    
}

func saveLastKnownVersionData() {
    //NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(appVersion), forKey: "WhatsNew_LastKnownVersion")
}



