//
//  LabelListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol LabelListViewModelProtocol: AnyObject {
    var didFetch: (() -> Void)? { get set }
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel
    func numberOfItem() -> Int
    func addNewLabel(title: String, desc: String, hexColor: String)
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String)
}

class LabelListViewModel: LabelListViewModelProtocol {
    
    private weak var labelProvider: LabelProvidable?
    
    var didFetch: (() -> Void)?
    private var labels = [LabelItemViewModel]()
    
    init(with labelProvider: LabelProvidable) {
        self.labelProvider = labelProvider
    }
    
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String) {
        labelProvider?.editLabel(id: labels[indexPath.row].id, title: title, description: desc, color: hexColor) { [weak self] (label) in
            guard let `self` = self,
                let label = label
                else { return }
            self.labels[indexPath.row] = LabelItemViewModel(label: label)
            DispatchQueue.main.async {
                self.didFetch?()
            }
        }
    }
    
    func addNewLabel(title: String, desc: String, hexColor: String) {
        labelProvider?.addLabel(title: title, description: desc, color: hexColor) { [weak self] (label) in
            guard let `self` = self,
                let label = label
                else { return }
            self.labels.append(LabelItemViewModel(label: label))
            DispatchQueue.main.async {
                self.didFetch?()
            }
        }
    }
    
    func needFetchItems() {
        labelProvider?.fetchLabels { [weak self] (datas) in
            guard let `self` = self,
                let labels = datas
                else { return }
            labels.forEach { self.labels.append(LabelItemViewModel(label: $0))  }
            DispatchQueue.main.async {
                self.didFetch?()
            }
        }
    }
    
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel {
        return labels[path.row]
    }
    
    func numberOfItem() -> Int {
        labels.count
    }
    
}
