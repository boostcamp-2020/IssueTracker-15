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
    case issueClosed = 1
    case issueFromMe = 2
    case issueAssignedToMe = 3
    
    var title: String {
        switch self {
        case .issueOpened:
            return "열린 이슈들"
        case .issueClosed:
            return "닫힌 이슈들"
        case .issueFromMe:
            return "내가 작성한 이슈들"
        case .issueAssignedToMe:
            return "나에게 할당된 이슈들"
        }
    }
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
