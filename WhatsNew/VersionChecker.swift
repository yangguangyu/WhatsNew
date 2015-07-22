//
//  VersionChecker.swift
//  WhatsNew
//
//  Created by Dave Levy on 7/21/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import Foundation
import UIKit

struct Version: Equatable, Comparable {
    
    let string: String
    var splitVersion: [Int]
    
    init?(string: String) {
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
        splitVersion = tempSplitVersion //? I forget what this accomplishes but I assume it's saving it for later use.
    }
    
}


func == (lhs: Version, rhs: Version) -> Bool {
    
    if lhs.string == rhs.string {
        println("Equality for all digits!")
        return true
    
    } else {
        return false
    }
}


func < (lhs: Version, rhs: Version) -> Bool {
    
    let (rhsPadded, lhsPadded) = padding(rhs, lhs) // both Versions should now be the same amt of digits
    
    var confirmed = false
    
    for var i = 0; i < Int(rhsPadded.count); i++ {
        
        var lhsInt = lhsPadded[i]
        var rhsInt = rhsPadded[i]
        
        if lhsInt < rhsInt {
            println("YES, It's less than the other version.")
            confirmed = true
            break
            
        } else if lhsInt > rhsInt {
            println("Nope, definitely not less than.")
            confirmed = false
            break
            
        } else {
            println("Not exactly sure yet, keep checking.")
            confirmed = false
            //don't break keep checking..
        }
        
    }
    return confirmed
}

func padding (rhs: Version, lhs:Version) -> ([Int], [Int]) { //this makes 3.1 match 3.1.0.0.0
    
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

    public static var isNewVersion: Bool { //check if it's a new version

        var new: Bool = true
        
        if let userData = //TODO: wrap in if let ACtually combine all two iflets
            NSUserDefaults.standardUserDefaults().valueForKey("WhatsNew_LastKnownVersion") as? NSData {
        
        
                if let lastKnownVersion = NSKeyedUnarchiver.unarchiveObjectWithData(userData) as? String {

                    let lastVersion = Version(string: lastKnownVersion)
                    
                    if (lastVersion < currentVersion) { //BOOM! this now uses new Version operator to compare!
                        new = true
                    } else {
                        new = false
                    }
                }
        }
        return new
    }

static var currentVersion: Version { //pull current version from launched App
    
    if let confirmedVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
        return Version(string: confirmedVersion)!

    } else {
        return Version(string: "0.0")!  //TODO: remove ! ?
    }
}

static func persistVersion () { //store current version to device
    
    NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(UIApplication.currentVersion.string), forKey: "WhatsNew_LastKnownVersion")
    }
}


