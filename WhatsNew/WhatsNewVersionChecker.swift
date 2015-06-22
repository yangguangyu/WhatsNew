//
//  WhatsNewVersionChecker.swift
//  WhatsNew
//
//  Created by Dave Levy on 6/22/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import Foundation

class WhatsNewVersionCheck  {
    
    static func checkVersionAgainstLastKnown() ->Bool   {
        var displayWhatsNew: Bool
        let currentAppVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! Version
        if let lastKnownVersionStored = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData { //stored value
            let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(lastKnownVersionStored) as! Version
            if (lastKnownVersion < currentAppVersion) {
                displayWhatsNew = true
            } else {
                displayWhatsNew = false
            }
        } else {  //no stored value
            displayWhatsNew = true
        }
        return displayWhatsNew
    }
    
    static func saveLatestVersionData(ver: Version) {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(ver), forKey: "WhatsNew_LastKnownVersion")
    }
    
    
}
