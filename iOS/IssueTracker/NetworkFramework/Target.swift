//
//  Target.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public protocol Target {
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var task: Task { get }
    
    var validationType: ValidationType { get }
    
    var headers: [String: String]? { get }
    
}
