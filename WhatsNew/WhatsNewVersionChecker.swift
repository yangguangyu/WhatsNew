//
//  WhatsNewVersionChecker.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/22/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import Foundation


class WhatsNewVersionCheck  {


// MARK: Check version

static func checkVersionAgainstLastKnown() ->Bool   {
    
    var displayWhatsNew: Bool
    
    let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
    
    if let lastKnownVersionData = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData
        
    {
        
        let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionData) as! Version
        
        //println("Last known version was \(lastKnownVersion).")
        
        if (lastKnownVersion < currentAppVersion) {
            
            //println("Cool, you have a new version!")
            
            displayWhatsNew = true
            
        } else {
            
            //println("No, it's not a new version.")
            
            displayWhatsNew = false
            
        }
        
    } else {
        
        //println("No idea what the last known version was, so show the alert.")
        
        displayWhatsNew = true
        
        
    }
    
    return displayWhatsNew
}

}
