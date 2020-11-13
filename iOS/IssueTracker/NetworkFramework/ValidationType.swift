//
//  ValidationType.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public enum ValidationType {
    case none
    case successCode // 2xx
    case custom([Int])
    
    var statusCode: [Int] {
        switch self {
        case .none:
            return []
        case .successCode:
            return Array(200..<300)
        case .custom(let codes):
            return codes
        }
    }
}
