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
    
        let oldVersions = ["0.0","1.0","2.2.1"].map{Version(string: $0)!} //MARK: check this out..
        let newVersions = ["0.1","1.0.1","2.10.1"].map{Version(string: $0)!}
        
        
        for i in 0..<oldVersions.count {
        
            XCTAssertLessThan(oldVersions[i], newVersions[i])

        }
        
            
        XCTAssertEqual(Version(string: "2.0")!, Version(string: "2.0")!, "Equality!")

        

        
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
