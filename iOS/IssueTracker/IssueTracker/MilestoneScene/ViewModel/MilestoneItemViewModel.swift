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
    var dueDate: String { get }
    var openIssue: String { get }
    var closedIssue: String { get }
    var percentage: String { get }
}

