//
//  WhatsNewTests.swift
//  WhatsNewTests
//
//  Created by Dave Levy on 6/19/15.
//  Copyright (c) 2015 Infusionsoft. All rights reserved.
//

import UIKit
import XCTest
import WhatsNew


class WhatsNewTests: XCTestCase { //TODO: write bunch of tests
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        
//        UIApplication.Ver

        
        ///XCTAssertEqual("1.2", UIApplication.isNewVersion, "Current version should be 1.2")
  
        ///XCTAssertEqual("1.2", UIApplication.currentVersion, "Current version should be 1.2")  //returns more expressive information
        
        //XCTAssertTrue(<#expression: BooleanType#>, <#message: String#>)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    //TODO: write test function  
    //Write test explicetly for version comparison
    
    
}
