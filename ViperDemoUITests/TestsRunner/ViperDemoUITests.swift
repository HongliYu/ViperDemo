//
//  ViperDemoUITests.swift
//  ViperDemoUITests
//
//  Created by Hongli Yu on 02.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import XCTest
import XCTest_Gherkin
@testable import ViperDemo

class ViperDemoUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasic() {
        NativeRunner.runFeature(featureFile: "basic.feature", testCase: self)
    }

}
