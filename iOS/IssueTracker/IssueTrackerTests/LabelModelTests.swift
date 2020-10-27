//
//  IssueTrackerTests.swift
//  IssueTrackerTests
//
//  Created by sihyung you on 2020/10/26.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import XCTest
@testable import IssueTracker

class LabelModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLabelInit() {
        let label = Label(title: "title", description: "설명", color: "#ABABAB")
        
        XCTAssertEqual(label.title, "title")
        XCTAssertEqual(label.description, "설명")
        XCTAssertEqual(label.color, "#ABABAB")
    }
}
