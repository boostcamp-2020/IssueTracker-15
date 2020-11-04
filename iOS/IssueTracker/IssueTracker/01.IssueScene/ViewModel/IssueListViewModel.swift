//
//  IssueListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol IssueListViewModelProtocol: AnyObject {
    var didFetch: (() -> Void)? { get set }
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> IssueItemViewModel
    func numberOfItem() -> Int
    
}

class IssueListViewModel: IssueListViewModelProtocol {
    
    private weak var labelProvider: LabelProvidable?
    private weak var milestoneProvider: MilestoneProvidable?
    private weak var issueProvider: IssueProvidable?
    
    var didFetch: (() -> Void)?
    private var labels = [IssueItemViewModel]()
    
    init(labelProvider: LabelProvidable, milestoneProvider: MilestoneProvidable, issueProvider: IssueProvidable) {
        self.labelProvider = labelProvider
        self.milestoneProvider = milestoneProvider
        self.issueProvider = issueProvider
    }
       
    func needFetchItems() {
        
    }
    
    func cellForItemAt(path: IndexPath) -> IssueItemViewModel {
        return IssueItemViewModel(issue: Issue(id: 0, author: "", title: ""))
    }
    
    func numberOfItem() -> Int {
        return 0
    }
    
}
