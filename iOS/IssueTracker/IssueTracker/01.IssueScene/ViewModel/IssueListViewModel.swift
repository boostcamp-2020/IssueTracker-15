//
//  IssueListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//
import Foundation

protocol IssueListViewModelProtocol: AnyObject {
    var didFetch: (() -> Void)? { get set }
    var invalidateLayout: (() -> Void)? { get set }
    var filter: IssueFilterable? { get set }
    
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> IssueItemViewModel
    func numberOfItem() -> Int
    
    func createFilterViewModel() -> IssueFilterViewModelProtocol?
    func createIssueDetailViewModel(path: IndexPath) -> IssueDetailViewModel?
}

class IssueListViewModel: IssueListViewModelProtocol {
    
    private weak var labelProvider: LabelProvidable?
    private weak var milestoneProvider: MilestoneProvidable?
    private weak var issueProvider: IssueProvidable?
    
    var filter: IssueFilterable?
    var didFetch: (() -> Void)?
    var invalidateLayout: (() -> Void)?
    
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
                self.issues.append(itemViewModel)
                self.labelProvider?.getLabels(of: $0.labels, completion: { [weak itemViewModel] (labels) in
                    itemViewModel?.setLabels(labels: labels)
                    self.invalidateLayout?()
                })
                
                if let milestoneID = $0.milestone {
                    self.milestoneProvider?.getMilestone(at: milestoneID, completion: { [weak itemViewModel] milestone in
                        itemViewModel?.setMilestone(milestone: milestone)
                        self.invalidateLayout?()
                    })
                }
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
    
    func createFilterViewModel() -> IssueFilterViewModelProtocol? {
        let generalConditions = filter?.generalConditions ?? [Bool](repeating: false, count: Condition.allCases.count)
        let detailConditions = filter?.detailConditions ?? [Int](repeating: -1, count: DetailCondition.allCases.count)
        let viewModel = IssueFilterViewModel(labelProvider: labelProvider,
                                             milestoneProvider: milestoneProvider,
                                             issueProvider: issueProvider,
                                             generalConditions: generalConditions,
                                             detailConditions: detailConditions)
        
        return viewModel
    }
    
    func createIssueDetailViewModel(path: IndexPath) -> IssueDetailViewModel? {
        let cellViewModel = issues[path.row]
        return IssueDetailViewModel(id: cellViewModel.id,
                                    title: cellViewModel.title,
                                    description: cellViewModel.description,
                                    issueProvider: issueProvider)
    }
}
