//
//  IssueItemViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

//protocol IssueItemViewModelProtocol: AnyObject {
//    var id: Int { get }
//    var title: String { get }
//    var milestoneTitle: String { get }
//    var labelItemViewModels: [LabelItemViewModel] { get }
//
//    var didMilestoneChanged: ((String) -> Void)? { get set }
//    var didLabelsChanged: (([LabelItemViewModel]) -> Void)? { get set }
//    var checked: Bool { get }
//}

//class IssueItemViewModel: IssueItemViewModelProtocol {
class IssueItemViewModel {
    
    let id: Int
    let title: String
    
    private(set) var milestoneTitle: String = ""
    private(set) var labelItemViewModels = [LabelItemViewModel]()
    
    var didMilestoneChanged: ((String) -> Void)?
    var didLabelsChanged: (([LabelItemViewModel]) -> Void)?
    
    var checked: Bool = false
    
    init(issue: Issue) {
        id = issue.id
        title = issue.title
    }
    
    func setLabels(labels: [Label]?) {
        guard let labels = labels else { return }
        labelItemViewModels = labels.map { LabelItemViewModel(label: $0) }
        didLabelsChanged?(labelItemViewModels)
    }
    
    func setMilestone(milestone: Milestone?) {
        guard let milestone = milestone else { return }
        milestoneTitle = milestone.title
        didMilestoneChanged?(milestoneTitle)
    }
    
}

extension IssueItemViewModel: Hashable {
    static func == (lhs: IssueItemViewModel, rhs: IssueItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
