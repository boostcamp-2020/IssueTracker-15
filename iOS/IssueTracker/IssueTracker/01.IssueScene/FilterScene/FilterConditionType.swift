//
//  FilterConditionType.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

enum Condition: Int, CaseIterable {
    case issueOpened = 0
    case issueFromMe = 1
    case issueAssignedToMe = 2
    case issueCommentedByMe = 3
    case issueClosed = 4
}

enum DetailSelectionType: Int, CaseIterable {
    case writer = 0
    case label = 1
    case milestone = 2
    case assignee = 3
    
    var title: String {
        switch self {
        case .writer:
            return "작성자"
        case .label:
            return "레이블"
        case .milestone:
            return "마일스톤"
        case .assignee:
            return "담당자"
        }
    }
    
    var cellStyle: ComponentStyle {
        switch self {
        case .writer, .assignee:
            return .userInfo
        case .label:
            return .label
        case .milestone:
            return .milestone
        }
    }
}
