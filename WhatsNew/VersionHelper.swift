//
//  VersionHelper.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import Foundation
import UIKit


typealias Version = String


class VersionHelper : NSObject {
    
    func checkVersionForWhatsNew(url: String) { //Check the actual version of the app that is loaded on the device.
        
        
        let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
        
        NSLog("App version loaded is %@", currentAppVersion)
        
        if let lastKnownVersionData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
            
            let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionData) as! Version
            
            NSLog("Yes, there is a saved version and it is @%.",lastKnownVersion)
            
            if (lastKnownVersion < currentAppVersion) {
                
                NSLog("Hey, there may be a popup alert here")
                
                /////////FIX showWhatsNewAlert(url)
                
            }
            
        } else {
            
            NSLog("No, we have no idea what the last known version was.")
            
            //So, show what's new if exists then save current version
            
            /////////FIX  showWhatsNewAlert(url)
            
        }
        
    }
    
    
    
    
    func saveLastKnownVersionData() {
        //NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(appVersion), forKey: "WhatsNew_LastKnownVersion")
    }
    
}

