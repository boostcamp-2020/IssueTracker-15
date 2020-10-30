//
//  milestoneViewModelTests.swift
//  IssueTrackerTests
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import XCTest
@testable import IssueTracker

class MilestoneItemViewModelTests: XCTestCase {

    func testInitializeMilestoneViewModel() {
        let milestone = IssueTracker.Milestone(id: 1, title: "스프린트2", description: "이번 배포를 위한 스프린트", dueDate: "2020-12-30 12:50:33")
        let viewModel = IssueTracker.MilestoneItemViewModel(milestone: milestone)
        
        XCTAssertEqual(viewModel.title, "스프린트2")
        XCTAssertEqual(viewModel.dueDateText, "2020년 12월 30일까지")
        XCTAssertEqual(viewModel.description, "이번 배포를 위한 스프린트")
        //TODO:- Issue에 대한 정보들이 어떤 방식으로 전달되는가?
    }

}
