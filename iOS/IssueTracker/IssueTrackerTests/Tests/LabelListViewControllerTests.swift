//
//  LabelListViewControllerTests.swift
//  IssueTrackerTests
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import XCTest
@testable import IssueTracker

class LabelListViewControllerTests: XCTestCase {
    
    let mockViewModel = LabelListViewModelMock()

    func makeSUT() -> IssueTracker.LabelListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "LabelListVC") as! IssueTracker.LabelListViewController
        vc.labelListViewModel = mockViewModel
        vc.loadView()
        return vc
    }
    
    func testNeedFetchLabelsCalled() {
        let vc = makeSUT()
        
        vc.viewDidLoad()
        
        XCTAssertTrue(mockViewModel.needFetchItemsCalled)
    }
    
}
