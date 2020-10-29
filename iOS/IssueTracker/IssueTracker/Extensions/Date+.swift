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
        DateFormatter.dateForMileStone.string(from: self)
    }
    
}