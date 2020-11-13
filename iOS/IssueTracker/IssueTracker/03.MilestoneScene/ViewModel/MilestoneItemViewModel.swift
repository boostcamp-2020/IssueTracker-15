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

protocol MilestoneSubmitFormConfigurable {
    var title: String { get }
    var description: String { get }
    var dueDateForForm: String { get }
}

enum DateFormatFrom {
    case fromServer
    case fromSubmitView
}

struct MilestoneItemViewModel: MilestoneCellConfigurable, MilestoneSubmitFormConfigurable {
    
    private(set) var id: Int
    private(set) var title: String
    private(set) var description: String
    private(set) var dueDate: Date?
    private(set) var issueOpened: Int = 0
    private(set) var issueClosed: Int = 0
    
    init(milestone: Milestone, from: DateFormatFrom) {
        self.id = milestone.id
        self.title = milestone.title
        self.description = milestone.description
        switch from {
        case .fromServer:
            self.dueDate = milestone.dueDate.dateForServer
        case .fromSubmitView:
            self.dueDate = milestone.dueDate.dateForSubmitForm
        }
        self.issueOpened = Int(milestone.openedIssueNum) ?? 0
        self.issueClosed = Int(milestone.closedIssueNum) ?? 0
    }
    
    var dueDateText: String {
        if let date = dueDate {
            return date.stringForMilestone + "까지"
        }
        return ""
    }
    
    var dueDateForForm: String {
        dueDate?.stringForSubmitForm ?? ""
    }
    
    var openIssue: String {
        "\(issueOpened) opened"
    }
    
    var closedIssue: String {
        "\(issueClosed) closed"
    }
    
    var percentage: String {
        guard issueOpened + issueClosed > 0 else { return "0%" }
        let percentile = issueOpened * 100 / (issueOpened + issueClosed)
        return "\(percentile)%"
    }
    
}
