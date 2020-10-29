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
    
    let testData = IssueTracker.LabelItemViewModel(label: IssueTracker.Label(title: "AAA", description: "BBB", hexColor: "#ABCDEF"))
    
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
        
        view.configure(labelViewModel: testData)
        
        XCTAssertEqual(view.titleField.text, testData.title)
        XCTAssertEqual(view.descField.text, testData.description)
        XCTAssertEqual(view.hexCodeField.text, testData.hexColor)
    }
    
    func testSubmit() {
        let view = makeSUT()
        view.configure(labelViewModel: testData)
        
        view.titleField.text = "TitleChanged"
        view.descField.text = "DescChanged"
        view.hexCodeField.text = "HexChanged"
        
        view.submitbuttonTapped = { (title, desc, hex) in
            XCTAssertEqual(title, "TitleChanged")
            XCTAssertEqual(desc, "DescChanged")
            XCTAssertEqual(hex, "HexChanged")
        }
        
        view.submitButtonTapped(UIButton())
    }
    
    func testRefresh() {
        let view = makeSUT()
        view.configure(labelViewModel: testData)
        
        view.resetFormButtonTapped(UIButton())
        
        XCTAssertEqual(view.titleField.text, "")
        XCTAssertEqual(view.descField.text, "")
        XCTAssertEqual(view.hexCodeField.text, "#000000")
    }
}
