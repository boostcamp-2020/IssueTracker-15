//
//  LabelListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol LabelList {
    var didFetch: (() -> Void)? { get set }
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel
    func numberOfItem() -> Int
}

class LabelsViewModel: LabelList {
    
    var didFetch: (() -> Void)?
    var labels = [Label]()
    
    func needFetchItems() {
        labels = [Label(title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                  Label(title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879")]
        didFetch?()
    }
    
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel {
        return LabelItemViewModel(label: labels[path.row])
    }
    
    func numberOfItem() -> Int {
        labels.count
    }
    
}
