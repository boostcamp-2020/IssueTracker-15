//
//  IssueFilterViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol IssueFilterViewModelProtocol: AnyObject {
    var generalConditions: [Bool] { get }
    var detailConditions: [Int] { get }
    
    func generalConditionSelected(at type: Condition)
    func detailConditionSelected(at type: DetailSelectionType, id: Int?)
    func condition(of type: Condition) -> Bool
    func detailCondition(of type: DetailSelectionType) -> CellComponentViewModel?
    func detailConditionDataSource(of type: DetailSelectionType) -> [[CellComponentViewModel]]
}

class IssueFilterViewModel: IssueFilterViewModelProtocol {
    
    private weak var labelProvider: LabelProvidable?
    private weak var milestoneProvider: MilestoneProvidable?
    private weak var issueProvider: IssueProvidable?
    
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
    
    func detailConditionSelected(at type: DetailSelectionType, id: Int?) {
        detailConditions[type.rawValue] = id ?? -1
    }
    
    func condition(of type: Condition) -> Bool {
        return generalConditions[type.rawValue]
    }
    
    func detailCondition(of type: DetailSelectionType) -> CellComponentViewModel? {
        let id = detailConditions[type.rawValue]
        if id == -1 { return nil }
        
        switch type {
        case .assignee, .writer:
            guard let user = issueProvider?.users[id] else { return nil }
            return CellComponentViewModel(user: user)
        case .label:
            guard let label = labelProvider?.labels[id] else { return nil }
            return CellComponentViewModel(label: label)
        case .milestone:
            guard let milestone = milestoneProvider?.milestons[id] else { return nil }
            return CellComponentViewModel(milestone: milestone)
        }
    }
    
    func detailConditionDataSource(of type: DetailSelectionType) -> [[CellComponentViewModel]] {
        var viewModels: [[CellComponentViewModel]] = [[], []]
        switch type {
        case .assignee, .writer:
            issueProvider?.users.forEach {
                let viewModel = CellComponentViewModel(user: $0.value)
                if let imageURL = $0.value.imageURL {
                    ImageLoader.shared.loadImage(from: imageURL, callBackQueue: .main) { [weak viewModel] (result) in
                        switch result {
                        case .failure, .success(.none):
                            return
                        case .success(.some(let data)):
                            viewModel?.onDataReceived(data: data)
                        }
                    }
                }
                viewModels[$0.value.id == detailConditions[type.rawValue] ? 0 : 1].append(viewModel)
            }
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
                let viewModel = CellComponentViewModel(milestone: $0.value)
                if $0.key == detailConditions[type.rawValue] {
                    viewModels[0].append(viewModel)
                } else {
                    viewModels[1].append(viewModel)
                }
            }
        }
        return viewModels
    }
    
}
