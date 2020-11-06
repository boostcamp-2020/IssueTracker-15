//
//  Date+.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension Date {
    
    var stringForMilestone: String {
        DateFormatter.dateForCollectionView.string(from: self)
    }
    
    var stringForSubmitForm: String {
        DateFormatter.dateForSubmitForm.string(from: self)
    }
    
    var stringForConditionCell: String {
        DateFormatter.dateForConditionCell.string(from: self)
    }
    
}
