//
//  LabelItemViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct LabelItemViewModel {
    
    let title: String
    let description: String
    let hexColor: String
    
    init(label: Label) {
        title = label.title
        description = label.description
        hexColor = label.hexColor
    }
    
}
