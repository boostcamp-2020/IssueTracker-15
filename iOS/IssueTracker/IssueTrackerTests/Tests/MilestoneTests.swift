//
//  MilestoneTests.swift
//  IssueTrackerTests
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import XCTest
@testable import IssueTracker

class MilestoneTests: XCTestCase {

    func testInitializeMilestone() {
        let milestone = IssueTracker.Milestone(id: 1, title: "스프린트2", description: "이번 배포를 위한 스프린트", dueDate: "2020-12-30 12:50:33")
        
        XCTAssertEqual(milestone.dueDate, "2020-12-30 12:50:33")
        XCTAssertEqual(milestone.id, 1)
        XCTAssertEqual(milestone.description, "이번 배포를 위한 스프린트")
        XCTAssertEqual(milestone.title, "스프린트2")
    }
    
}
