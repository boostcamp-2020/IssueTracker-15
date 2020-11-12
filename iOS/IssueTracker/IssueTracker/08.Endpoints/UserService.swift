//
//  UserService.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

enum UserService: IssueTrackerService {
    
    case fetchUser
    
    var path: String {
        return "/api/user"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var validationType: ValidationType {
        return .successCode
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var queryItems: [String : String]? {
        return nil
    }
    
}
