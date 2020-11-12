//
//  IssueFilter.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol IssueFilterable: AnyObject {
    var generalConditions: [Bool] { get set }
    var detailConditions: [Int] { get set }
    var searchText: String? { get set }
    func filter(datas: [Issue], user: User?) -> [Issue]
}

class IssueFilter: IssueFilterable {
    
    var generalConditions = [Bool](repeating: false, count: Condition.allCases.count)
    var detailConditions = [Int](repeating: -1, count: DetailSelectionType.allCases.count)
    var searchText: String?
    
    init() {
        self.generalConditions[0] = true
    }
    
    init(generalCondition: [Bool], detailCondition: [Int]) {
        guard detailCondition.count == DetailSelectionType.allCases.count,
            generalCondition.count == Condition.allCases.count
            else { return }
        self.generalConditions = generalCondition
        self.detailConditions = detailCondition
    }
    
    func filter(datas: [Issue], user: User?) -> [Issue] {
        
        var dataSet = Set<Issue>()
        if generalConditions[Condition.issueOpened.rawValue] {
            dataSet = dataSet.union(datas.filter { $0.isOpened })
        }
        
        if generalConditions[Condition.issueClosed.rawValue] {
            dataSet = dataSet.union(datas.filter { !$0.isOpened })
        }
        
        if generalConditions[Condition.issueAssignedToMe.rawValue] {
            dataSet = dataSet.intersection(datas.filter {
                $0.assignees.contains(where: {
                    $0 == user?.id
                })
            })
        }
        
        if generalConditions[Condition.issueFromMe.rawValue] {
            dataSet = dataSet.intersection(datas.filter {
                $0.author == user?.id
            })
        }
        
        // TODO: Detail Condition
        if let id = detailConditions[safe: DetailSelectionType.assignee.rawValue],
            id != -1 {
            dataSet = dataSet.intersection(datas.filter { $0.assignees.contains(where: { $0 == id })})
        }

        if let id = detailConditions[safe: DetailSelectionType.writer.rawValue],
            id != -1 {
            dataSet = dataSet.intersection(datas.filter { $0.author == id })
        }
        
        if let id = detailConditions[safe: DetailSelectionType.label.rawValue],
            id != -1 {
            dataSet = dataSet.intersection(datas.filter { $0.labels.contains(where: { $0 == id })})
        }
        
        if let id = detailConditions[safe: DetailSelectionType.milestone.rawValue],
            id != -1 {
            dataSet = dataSet.intersection(datas.filter { $0.milestone ?? -1 ==  id })
        }
        
        if let searchTarget = self.searchText {
            dataSet = dataSet.filter { $0.title.contains(searchTarget) }
        }
        
        return dataSet.sorted { (lhs, rhs) -> Bool in
            guard let dateLhs = lhs.createdAt.datdForServer,
                let dateRhs = rhs.createdAt.datdForServer
                else { return true }
            
            return dateLhs > dateRhs
        }
    }
}
