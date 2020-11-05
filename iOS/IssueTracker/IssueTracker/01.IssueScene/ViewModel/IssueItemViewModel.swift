//
//  IssueItemViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

class IssueItemViewModel {
    
    let id: Int
    let title: String
    let description: String
    
    private(set) var milestoneTitle: String = ""
    private(set) var labelTitle: String = ""
    private(set) var labelColor: String = ""
    var check: Bool = false {
        didSet {
            didSelected?(check)
        }
    }
    
    var didSelected: ((Bool) -> Void)?
    var didLabelChanged: ((String, String) -> Void)?
    var didMilestoneChanged: ((String) -> Void)?
    
    
    init(issue: Issue) {
        id = issue.id
        title = issue.title
        description = issue.description
    }
    
    func setLabel(label: Label?) {
        guard let label = label else { return }
        labelTitle = label.title
        labelColor = label.hexColor
        didLabelChanged?(labelTitle, labelColor)
    }
    
    func setMilestone(milestone: Milestone?) {
        guard let milestone = milestone else { return }
        milestoneTitle = milestone.title
        didMilestoneChanged?(milestoneTitle)
    }
    
}
