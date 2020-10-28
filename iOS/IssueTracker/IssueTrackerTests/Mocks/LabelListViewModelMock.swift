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
    var numberOfItemCalled = false
    var addNewLabelCalled = false
    var editLabelCalled = false
    
    func needFetchItems() {
        needFetchItemsCalled = true
    }
    
    func cellForItemAt(path: IndexPath) -> IssueTracker.LabelItemViewModel {
        cellForItemAtCalled = true
        return IssueTracker.LabelItemViewModel(label: IssueTracker.Label(title: "A", description: "B", hexColor: "C"))
    }
    
    func numberOfItem() -> Int {
        numberOfItemCalled = true
        return 1
    }
    
    func addNewLabel(title: String, desc: String, hexColor: String) {
        addNewLabelCalled = true
    }
    
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String) {
        editLabelCalled = true
    }
    
}
