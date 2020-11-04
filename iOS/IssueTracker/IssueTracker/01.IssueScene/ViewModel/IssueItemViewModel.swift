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
    
    let milestoneTitle: String
    let labelTitle: String
    let labelColor: String
    
    var check: Bool = false
    
    init(issue: Issue, label: Label? = nil, milestone: Milestone? = nil) {
        id = issue.id
        title = issue.title
        description = issue.description
        
        milestoneTitle = milestone?.title ?? ""
        labelTitle = label?.title ?? ""
        labelColor = label?.hexColor ?? ""
    }
    
}
