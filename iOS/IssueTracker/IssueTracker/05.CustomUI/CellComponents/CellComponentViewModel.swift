//
//  ConditionCellConfigurable.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

struct CellComponentViewModel {
    let id: Int
    let title: String
    let element: String
    
    init(title: String, element: String) {
        self.id = 0
        self.title = title
        self.element = element
    }
    
    init(label: Label) {
        id = label.id
        title = label.title
        element = label.hexColor
    }
    
    init(milestone: Milestone) {
        id = milestone.id
        title = milestone.title
        element = milestone.dueDate
    }
    
    init(user: User) {
        id = user.id
        title = user.userName
        element = user.imageURL ?? ""
    }
    
    // TODO:
    /*
     init(userInfo: UserInfo) {
     title = userInfo.name
     element = userInfo.imageUrl
     }
     */
}
