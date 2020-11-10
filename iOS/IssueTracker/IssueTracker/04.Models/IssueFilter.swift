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
    
    func filter(datas: [Issue]) -> [Issue]
}

class IssueFilter: IssueFilterable {
    
    var generalConditions = [Bool](repeating: false, count: Condition.allCases.count)
    var detailConditions = [Int](repeating: -1, count: DetailSelectionType.allCases.count)
    
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
    
    func filter(datas: [Issue]) -> [Issue] {
        
        return []
    }
}
