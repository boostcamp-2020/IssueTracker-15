//
//  IssueDetailViewModel.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

class IssueDetailViewModel {
    
    var issueNumber: Int = 0
    var title: String = ""
    var description: String = ""
    var author: String = ""
    var badge: String = ""
    var didFetch: (() -> Void)?
    var isOpened: Bool = false
    private weak var issueProvider: IssueProvidable?
    
    init(issueProvider: IssueProvidable) {
        self.issueProvider = issueProvider
    }
    
    func needFetchDetails(with id: Int) {
        issueProvider?.getIssue(at: id, completion: { [weak self] (issue) in
            guard let `self` = self,
                let currentIssue = issue
                else { return }
            
            self.issueNumber = currentIssue.id
            self.title = currentIssue.title
            self.isOpened = currentIssue.isOpened
            self.badge = self.isOpened ? "Open" : "Closed"
            self.description = currentIssue.description
            self.author = currentIssue.author
            self.didFetch?()
        })
    }
}
