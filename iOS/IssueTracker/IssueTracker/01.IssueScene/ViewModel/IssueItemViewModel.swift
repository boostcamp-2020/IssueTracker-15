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
    private(set) var labelItemViewModels = [LabelItemViewModel]()
    private(set) var labelTitle: String = ""
    private(set) var labelColor: String = ""
    
    var didMilestoneChanged: ((String) -> Void)?
    var didLabelsChanged: (([LabelItemViewModel]) -> Void)?
    
    var check: Bool = false
    
    init(issue: Issue) {
        id = issue.id
        title = issue.title
        description = issue.description
    }
    
    func setLabels(labels: [Label]?) {
        guard let labels = labels else { return }
        labelItemViewModels = labels.map { LabelItemViewModel(label: $0) }
        didLabelsChanged?(labelItemViewModels)
    }
    
    func setMilestone(milestone: Milestone?) {
        guard let milestone = milestone else { return }
        milestoneTitle = milestone.title
        didMilestoneChanged?(milestoneTitle)
    }
    
}
