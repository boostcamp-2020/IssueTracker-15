//
//  LabelListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

class LabelListViewModel {
    
    let tempLabels: [Label] = [Label(title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                               Label(title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879")]
    
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel {
        return LabelItemViewModel(label: tempLabels[path.row])
    }

    func numberOfItem() -> Int {
        tempLabels.count
    }
    
}
