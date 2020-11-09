//
//  IssueDetailViewModel.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

enum IssueBadgeColor {
    case green
    case red
}

protocol IssueDetailViewModelProtocol {
    var issueNumber: Int { get }
    var title: String { get }
    var description: String { get }
    var author: String { get }
    var badge: String { get }
    var badgeColor: IssueBadgeColor { get }
    
    var didFetch: (() -> Void)? { get set }
    func needFetchDetails()
}

class IssueDetailViewModel: IssueDetailViewModelProtocol {
    
    var issueNumber: Int = 0
    var title: String = ""
    var description: String = ""
    var author: String = ""
    var didFetch: (() -> Void)?
    
    private weak var issueProvider: IssueProvidable?
    private var isOpened: Bool = false
    
    init(id: Int, title: String, description: String, issueProvider: IssueProvidable?) {
        self.issueProvider = issueProvider
        self.issueNumber = id
        self.title = title
        self.description = description
    }
    
    func needFetchDetails() {
        issueProvider?.getIssue(at: issueNumber, completion: { [weak self] (issue) in
            guard let `self` = self,
                let currentIssue = issue
                else { return }
            
            self.issueNumber = currentIssue.id
            self.title = currentIssue.title
            self.isOpened = currentIssue.isOpened
            self.description = currentIssue.description
            self.author = currentIssue.author
            self.didFetch?()
        })
    }
}
