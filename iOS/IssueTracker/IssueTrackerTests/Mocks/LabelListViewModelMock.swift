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
    
    var needFetchItemsCalled = false
    
    var cellForItemAtCalled = false
    var calledCellIndexPath: IndexPath?
    
    var numberOfItemCalled = false
    
    var addNewLabelCalled = false
    var addedLabel: IssueTracker.Label?
    
    var editLabelCalled = false
    var edittedIndex: IndexPath?
    
    var labels = [IssueTracker.Label]()
    
    var didFetch: (() -> Void)?
    
    func needFetchItems() {
        needFetchItemsCalled = true
    }
    
    func cellForItemAt(path: IndexPath) -> IssueTracker.LabelItemViewModel {
        calledCellIndexPath = path
        cellForItemAtCalled = true
        return IssueTracker.LabelItemViewModel(label: labels[path.row])
    }
    
    func numberOfItem() -> Int {
        numberOfItemCalled = true
        return labels.count
    }
    
    func addNewLabel(title: String, desc: String, hexColor: String) {
        labels.append(IssueTracker.Label(title: title, description: desc, hexColor: hexColor))
    }
    
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String) {
        labels[indexPath.row] = IssueTracker.Label(title: title, description: desc, hexColor: hexColor)
    }
    
}
