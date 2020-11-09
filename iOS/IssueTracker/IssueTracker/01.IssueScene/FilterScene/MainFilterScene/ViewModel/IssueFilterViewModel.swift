//
//  IssueFilterViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol IssueFilterViewModelProtocol: AnyObject {
    var generalConditions: [Bool] { get }
    var detailConditions: [Int] { get }
    
    func generalConditionSelected(at type: Condition)
    func detailConditionSelected(at type: DetailCondition, id: Int?)
    func condition(of type: Condition) -> Bool
    func detailCondition(of type: DetailCondition) -> CellComponentViewModel?
    func detailConditionDataSource(of type: DetailCondition) -> [[CellComponentViewModel]]
}

class IssueFilterViewModel: IssueFilterViewModelProtocol {
    
    private weak var labelProvider: LabelProvidable?
    private weak var milestoneProvider: MilestoneProvidable?
    private weak var issueProvider: IssueProvidable?
    
    // TODO: UserInfoProvider
    private var mockUserInfo = [
        CellComponentViewModel(title: "SHIVVVPP", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "유시형", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "namda-on", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "moaikang", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "maong0927", element: "2020-08-11T00:00:00.000Z")
       ]
    
    private(set) var generalConditions: [Bool]
    private(set) var detailConditions: [Int]
    
    init(labelProvider: LabelProvidable?,
         milestoneProvider: MilestoneProvidable?,
         issueProvider: IssueProvidable?,
         generalConditions: [Bool],
         detailConditions: [Int] ) {
        self.generalConditions = generalConditions
        self.detailConditions = detailConditions
        self.labelProvider = labelProvider
        self.milestoneProvider = milestoneProvider
        self.issueProvider = issueProvider
    }
    
    func generalConditionSelected(at type: Condition) {
        generalConditions[type.rawValue] = !generalConditions[type.rawValue]
    }
    
    func detailConditionSelected(at type: DetailCondition, id: Int?) {
        detailConditions[type.rawValue] = id ?? -1
    }
    
    func condition(of type: Condition) -> Bool {
        return generalConditions[type.rawValue]
    }
    
    func detailCondition(of type: DetailCondition) -> CellComponentViewModel? {
        let id = detailConditions[type.rawValue]
        if id == -1 { return nil }
        
        switch type {
        case .assignee, .writer:
            return mockUserInfo.first(where: {$0.id == id})
        case .label:
            guard let label = labelProvider?.labels[id] else { return nil }
            return CellComponentViewModel(label: label)
        case .milestone:
            guard let milestone = milestoneProvider?.milestons.first(where: {$0.id == id}) else { return nil }
            return CellComponentViewModel(milestone: milestone)
        }
    }
    
    func detailConditionDataSource(of type: DetailCondition) -> [[CellComponentViewModel]] {
        var viewModels: [[CellComponentViewModel]] = [[], []]
        switch type {
        case .assignee, .writer:
            // TODO: UserInfoProvider 구현
            viewModels = [ [], mockUserInfo  ]
        case .label:
            labelProvider?.labels.forEach {
                let viewModel = CellComponentViewModel(label: $0.value)
                if $0.key == detailConditions[type.rawValue] {
                    viewModels[0].append(viewModel)
                } else {
                    viewModels[1].append(viewModel)
                }
            }
        case .milestone:
            milestoneProvider?.milestons.forEach {
                let viewModel = CellComponentViewModel(milestone: $0)
                if $0.id == detailConditions[type.rawValue] {
                    viewModels[0].append(viewModel)
                } else {
                    viewModels[1].append(viewModel)
                }
            }
        }
        return viewModels
    }
    
}
