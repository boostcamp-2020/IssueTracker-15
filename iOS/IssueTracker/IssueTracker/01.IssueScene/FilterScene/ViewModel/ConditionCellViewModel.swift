//
//  ConditionCellConfigurable.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

struct ConditionCellViewModel {
    let title: String
    let element: String
    
    init(title: String, element: String) {
        self.title = title
        self.element = element
    }
    
    init(label: Label) {
        title = label.title
        element = label.hexColor
    }
    
    init(milestone: Milestone) {
        title = milestone.title
        element = milestone.dueDate
    }
    
    // TODO:
    /*
     init(userInfo: UserInfo) {
     title = userInfo.name
     element = userInfo.imageUrl
     }
     */
}
