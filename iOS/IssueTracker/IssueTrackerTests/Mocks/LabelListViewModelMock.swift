//
//  LabelListViewModelMock.swift
//  IssueTrackerTests
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
@testable import IssueTracker

class LabelListViewModelMock: IssueTracker.LabelListViewModelProtocol {
    
    var didFetch: (() -> Void)?
    
    var needFetchItemsCalled = false
    
    var cellForItemAtCalled = false
    var calledCellIndexPath: IndexPath?
    
    var numberOfItemCalled = false
    var numberOfItemValue = 0
    
    func needFetchItems() {
        needFetchItemsCalled = true
    }
    
    func cellForItemAt(path: IndexPath) -> IssueTracker.LabelItemViewModel {
        calledCellIndexPath = path
        cellForItemAtCalled = true
        return IssueTracker.LabelItemViewModel(label: IssueTracker.Label(title: "A", description: "B", hexColor: "C"))
    }
    
    func numberOfItem() -> Int {
        numberOfItemCalled = true
        return 10
    }
    
    func addNewLabel(title: String, desc: String, hexColor: String) {
        
    }
    
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String) {
        
    }
    
}
