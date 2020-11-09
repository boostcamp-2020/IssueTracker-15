//
//  IssueTrackerAPIs.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol IssueTrackerService: Target {
    
}

extension IssueTrackerService {
    var baseURL: URL { return URL(string: "http://118.67.134.194:3000")! }
}
