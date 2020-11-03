//
//  LabelListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol LabelListViewModelProtocol: AnyObject {
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
        labels[indexPath.row] = Label(title: title, description: desc, hexColor: hexColor)
        
        didFetch?()
    }
    
    func addNewLabel(title: String, desc: String, hexColor: String) {
        let newLabel: Label = Label(title: title, description: desc, hexColor: hexColor)
        labels.insert(newLabel, at: 0)
        
        didFetch?()
    }
    
    func needFetchItems() {
        // 네트워크 통신으로 fetch
    }
    
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel {
        return LabelItemViewModel(label: labels[path.row])
    }
    
    func numberOfItem() -> Int {
        labels.count
    }
    
}
