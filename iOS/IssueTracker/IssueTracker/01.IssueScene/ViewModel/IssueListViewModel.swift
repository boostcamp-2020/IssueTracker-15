//
//  IssueListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol IssueListViewModelProtocol: AnyObject {
    var filterViewModel: IssueFilterViewModelProtocol? { get }
    var didFetch: (() -> Void)? { get set }
    var filter: IssueFilterable? { get set }
    
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> IssueItemViewModel
    func numberOfItem() -> Int
    
    func selectItemAt(path: IndexPath)
    func selectAll()
    func clearAll()
}

class IssueListViewModel: IssueListViewModelProtocol {
    
    private weak var labelProvider: LabelProvidable?
    private weak var milestoneProvider: MilestoneProvidable?
    private weak var issueProvider: IssueProvidable?
    
    var filter: IssueFilterable?
    var didFetch: (() -> Void)?
    private var issues = [IssueItemViewModel]()
    
    init(labelProvider: LabelProvidable, milestoneProvider: MilestoneProvidable, issueProvider: IssueProvidable) {
        self.labelProvider = labelProvider
        self.milestoneProvider = milestoneProvider
        self.issueProvider = issueProvider
    }
    
    func needFetchItems() {
        issueProvider?.fetchIssues(completion: { [weak self] (datas) in
            guard let `self` = self,
                let issues = datas
                else { return }
            
            issues.forEach {
                let itemViewModel = IssueItemViewModel(issue: $0)
                if let labelID = $0.labels.first {
                    self.labelProvider?.getLabel(at: labelID, completion: { [weak itemViewModel] label in
                        itemViewModel?.setLabel(label: label)
                    })
                }
                if let milestoneID = $0.milestone {
                    self.milestoneProvider?.getMilestone(at: milestoneID, completion: { [weak itemViewModel] milestone in
                        itemViewModel?.setMilestone(milestone: milestone)
                    })
                }
                self.issues.append(itemViewModel)
            }
            
            DispatchQueue.main.async {
                self.didFetch?()
            }
        })
    }
    
    func cellForItemAt(path: IndexPath) -> IssueItemViewModel {
        return issues[path.row]
    }
    
    func numberOfItem() -> Int {
        return issues.count
    }
    
    func selectItemAt(path: IndexPath) {
        issues[path.row].check = !issues[path.row].check
    }
    
    func selectAll() {
        issues.forEach { $0.check = true }
    }
    
    func clearAll() {
        issues.forEach { $0.check = false }
    }
    
    var filterViewModel: IssueFilterViewModelProtocol? {
        let generalConditions = filter?.generalConditions ?? [Bool](repeating: false, count: Condition.allCases.count)
        let detailConditions = filter?.detailConditions ?? [Int](repeating: -1, count: DetailCondition.allCases.count)
        let viewModel = IssueFilterViewModel(labelProvider: labelProvider,
                                             milestoneProvider: milestoneProvider,
                                             issueProvider: issueProvider,
                                             generalConditions: generalConditions,
                                             detailConditions: detailConditions)
        
        return viewModel
    }
    
}
