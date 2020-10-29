//
//  DateFormatter+.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let dateFromMileStone: DateFormatter = {
        let formatter = DateFormatter()
        // TODO: 서버에서 받은 시간 형식에 따라 변경
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static let dateForMileStone: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
}
