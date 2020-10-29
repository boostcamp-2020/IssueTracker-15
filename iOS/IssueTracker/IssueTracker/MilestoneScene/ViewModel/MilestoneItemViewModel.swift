//
//  MilestoneItemViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol MilestoneCellConfigurable {
    var title: String { get }
    var description: String { get }
    var dueDateText: String { get }
    var openIssue: String { get }
    var closedIssue: String { get }
    var percentage: String { get }
}

struct MilestoneCellViewModel: MilestoneCellConfigurable {
    
    private(set) var title: String
    private(set) var description: String
    private(set) var dueDate: Date
    private(set) var issueOpened: Int = 0
    private(set) var issueClosed: Int = 0
    
    init(milestone: Milestone) {
        self.title = milestone.title
        self.description = milestone.description
        // TODO:- TIMESTAMP 형식 데이터를 알맞게 변환
        self.dueDate = Date()
    }
    
    var dueDateText: String {
        dueDate.stringForMilestone + "까지"
    }
    
    var openIssue: String {
        "\(issueOpened) opened"
    }
    
    var closedIssue: String {
        "\(issueClosed) closed"
    }
    
    var percentage: String {
        let percentile = issueOpened * 100 / issueClosed
        return "\(percentile)%"
    }
    
}
