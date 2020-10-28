//
//  LabelSubmitFormViewTests.swift
//  IssueTrackerTests
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import XCTest
@testable import IssueTracker

class LabelSubmitFormViewTests: XCTestCase {
    
    func makeSUT() -> IssueTracker.LabelSubmitFormView {
        return IssueTracker.LabelSubmitFormView.createView()!
    }
    
    func testConfigureWithNil() {
        let view = makeSUT()
        
        view.configure()
        
        XCTAssertEqual(view.titleField.text, "")
        XCTAssertEqual(view.descField.text, "")
        XCTAssertEqual(view.hexCodeField.text, "#000000")
    }
    
    func testConfigure() {
        let view = makeSUT()
        
        let testData = IssueTracker.LabelItemViewModel(label: IssueTracker.Label(title: "AAA", description: "BBB", hexColor: "#ABCDEF"))
        view.configure(labelViewModel: testData)
        
        XCTAssertEqual(view.titleField.text, testData.title)
        XCTAssertEqual(view.descField.text, testData.description)
        XCTAssertEqual(view.hexCodeField.text, testData.hexColor)
    }
}
