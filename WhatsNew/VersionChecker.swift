//
//  VersionChecker.swift
//  WhatsNew
//
//  Created by Dave Levy on 7/21/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import Foundation
import UIKit

//MARK: Version and logic
public struct Version: Equatable, Comparable, Printable {
    
    let string: String
    var splitVersion: [Int]
    
    public var description: String {
        
        return string
    }
    
    public init?(string: String) {
        
        self.string = string
        let splitVersionAsStrings = split(string) { $0 == "." }
        var tempSplitVersion = [Int]()
        
        for splitString in splitVersionAsStrings {
            
            if let splitInt = splitString.toInt() {
                
                tempSplitVersion.append(splitInt)
                
            } else {
                
                return nil
            }
        }
        splitVersion = tempSplitVersion
    }
}


public func == (lhs: Version, rhs: Version) -> Bool {
    
    var result: Bool = false
    result = lhs.string == rhs.string
    return result
    
}


public func < (lhs: Version, rhs: Version) -> Bool {
    
    let (rhsPadded, lhsPadded) = padding(rhs, lhs) // both Versions should now be same amt of digits
    var lessThan = false

    for var i = 0; i < Int(rhsPadded.count); i++ {
        
        var lhsInt = lhsPadded[i]
        var rhsInt = rhsPadded[i]
        
        if lhsInt < rhsInt {
            //println("Yes, It's less than the other version.")
            lessThan = true
            break
            
        } else if lhsInt > rhsInt {
            //println("Nope, definitely not less than.")
            lessThan = false
            break
            
        } else {
            //println("Not exactly sure yet, keep checking.")
            lessThan = false
            //don't break keep checking..
        }
        
    }
    return lessThan
}

public func padding (rhs: Version, lhs:Version) -> ([Int], [Int]) { //this makes 3.1 match 3.1.0.0.0
    
    var tempSplitRhs = rhs.splitVersion
    var tempSplitLhs = lhs.splitVersion
    
    if tempSplitRhs.count < tempSplitLhs.count { //if rhs is less than lhs add zeros
        
        let x = tempSplitLhs.count - tempSplitRhs.count
        for var i = 0; i < Int(x); i++ {
            
            tempSplitRhs.append(0)
            
        }
    } else if tempSplitLhs.count < tempSplitRhs.count { //if lhs is less than rhs add zeros
        
        let x = tempSplitRhs.count - tempSplitLhs.count
        for var i = 0; i < Int(x); i++ {
            
            tempSplitLhs.append(0)
        }
    }
    return ( tempSplitRhs, tempSplitLhs )
}


//MARK: UIApplication extensions

extension UIApplication {
    
    public static var isFirstRun: Bool {
        
        if (NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") == nil) {
           
            persistVersion()
            return true //first run!
            
        } else {
            
            return false //not my first rodeo
        }
    }
    
    public static var isUpdatedVersion: Bool { //TODO:..  make it so that on first run has the option to show a popup, or present other information.
        
        var result: Bool = false
        
        if let lastKnownVersion = NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? String, lastVersion = Version(string: lastKnownVersion) {
            
            result = lastVersion < currentVersion

        }
        return result
    }

    
    public static var currentVersion: Version {
        
        if let appVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            
            if let appVersionLegit = Version(string: appVersion) {
                
                return appVersionLegit
                
            } else {
                
                NSLog("Unconventional version name.. How unique.")
                return Version(string: "0.0")!
            }
        } else {
            
            NSLog("No version were detected.. That's weird.")
            return Version(string: "0.0")!
        }
    }
    
    public static func persistVersion () {
        
        NSUserDefaults.standardUserDefaults().setObject(currentVersion.string, forKey: "WhatsNew_LastKnownVersion")
    }
}


