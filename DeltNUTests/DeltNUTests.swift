//
//  DeltNUTests.swift
//  DeltNUTests
//
//  Created by Canon Sawrey on 3/6/20.
//  Copyright © 2020 Canon Sawrey. All rights reserved.
//

import XCTest

@testable import DeltNU

class DeltNUTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEncryption() {
        let saltCache = Encrypt()
        let str = "@..d./{},u81ejdio32jdfi;jnfk%^&O&*!_@cujbaew;{}|-`~~0-f3j2hc~!`,1<>?oinbew&@$!_ce*(@!#!wncui23"
        let encrypted = saltCache.quickEncrypt(str)
        let decrypted = saltCache.quickDecrypt(encrypted)
        assert(str == decrypted)
        print(decrypted)
        
    }
    
    func testEncryption2() {
        let saltCache = Encrypt()
        let str = "sawrey.c@husky.neu.edu"
        let encrypted = saltCache.quickEncrypt(str)
        let decrypted = saltCache.quickDecrypt(encrypted)
        assert(str == decrypted)
        print(decrypted)
    }

}
