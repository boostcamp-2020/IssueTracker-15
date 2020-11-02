//
//  LabelListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol LabelListViewModelProtocol {
    var didFetch: (() -> Void)? { get set }
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel
    func numberOfItem() -> Int
    func addNewLabel(title: String, desc: String, hexColor: String)
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String)
}

class LabelListViewModel: LabelListViewModelProtocol {
    
    var didFetch: (() -> Void)?
    private var labels = [Label]()
    
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String) {
        labels[indexPath.row] = Label(id: 0, title: title, description: desc, hexColor: hexColor)
        
        didFetch?()
    }
    
    func addNewLabel(title: String, desc: String, hexColor: String) {
        let newLabel: Label = Label(id: 0, title: title, description: desc, hexColor: hexColor)
        labels.insert(newLabel, at: 0)
        
        didFetch?()
    }
    
    func needFetchItems() {
        labels = [Label(id: 0, title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                  Label(id: 0, title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879"),
                  Label(id: 0, title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                  Label(id: 0, title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879"),
                  Label(id: 0, title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                  Label(id: 0, title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879"),
                  Label(id: 0, title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                  Label(id: 0, title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879"),
                  Label(id: 0, title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                  Label(id: 0, title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879"),
                  Label(id: 0, title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                  Label(id: 0, title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879")]
        didFetch?()
    }
    
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel {
        return LabelItemViewModel(label: labels[path.row])
    }
    
    func numberOfItem() -> Int {
        labels.count
    }
    
}
