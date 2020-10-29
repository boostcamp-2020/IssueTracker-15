//
//  LabelCellViewTest.swift
//  IssueTrackerTests
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import XCTest
@testable import IssueTracker

class LabelCellViewTest: XCTestCase {
    
    func makeSUT() -> IssueTracker.LabelCellView {
        return Bundle.main.loadNibNamed(IssueTracker.LabelCellView.cellID, owner: nil, options: nil)!.last! as! IssueTracker.LabelCellView
    }

    func testConfigure() {
        let cell = makeSUT()

        let testData = IssueTracker.LabelItemViewModel(label: IssueTracker.Label(title: "TEST", description: "TESTDESC", hexColor: "#ABCDEF"))
        cell.configure(with: testData)
        
        XCTAssertEqual(cell.titleLabel.text!, testData.title)
        XCTAssertEqual(cell.descriptionLabel.text!, testData.description)
        XCTAssertEqual(cell.titleLabel.layer.backgroundColor, testData.hexColor.color)
    }
    
}
