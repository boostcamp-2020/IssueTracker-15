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
}

class IssueFilter: IssueFilterable {
    
    var generalConditions = [Bool](repeating: false, count: Condition.allCases.count)
    var detailConditions = [Int](repeating: -1, count: DetailCondition.allCases.count)
    
    init(generalCondition: [Bool], detailCondition: [Int]) {
        guard detailCondition.count == DetailCondition.allCases.count,
        generalCondition.count == Condition.allCases.count
            else { return }
        self.generalConditions = generalCondition
        self.detailConditions = detailCondition
    }
}
