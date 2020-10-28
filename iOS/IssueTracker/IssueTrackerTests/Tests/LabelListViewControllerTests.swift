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
    
    func testCellForItemCalled() {
        let vc = makeSUT()
        vc.viewDidLoad()
        
        let _ = vc.collectionView(vc.collectionView, cellForItemAt: IndexPath(row: 5, section: 0))
        
        XCTAssertTrue(mockViewModel.cellForItemAtCalled)
        XCTAssertEqual(mockViewModel.calledCellIndexPath, IndexPath(row: 5, section: 0))
    }
    
    func testNumberOfItemCalled() {
        let vc = makeSUT()
        vc.viewDidLoad()
        mockViewModel.numberOfItemValue = 10
        
        let numberOfItem = vc.collectionView(vc.collectionView, numberOfItemsInSection: 0)
        
        XCTAssertTrue(mockViewModel.numberOfItemCalled)
        XCTAssertEqual(numberOfItem, mockViewModel.numberOfItemValue)
    }
    
}
