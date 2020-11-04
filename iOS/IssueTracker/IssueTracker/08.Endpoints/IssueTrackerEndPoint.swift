//
//  IssueTrackerService.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

class IssueTrackerEndpoint: EndPoint {
    
    enum RequestType {
        case fetch
        case create
        case edit
        case delete
    }
    
    var requestType: RequestType
    
    init(requestType: RequestType) {
        self.requestType = requestType
    }

    var scheme: String { "http" }
    
    var httpBody: Data? // = nil
    
    var baseURL: String { "118.67.134.194" }
    
    var port: Int { 3000 }
    
    var path: String { "" }
    
    var method: HTTPMethod {
        switch requestType {
        case .fetch:
            return .get
        case .create:
            return .post
        case .edit:
            return .patch
        case .delete:
            return .delete
        }
    }
    
    var statusCode: Int {
        switch requestType {
        case .fetch, .edit:
            return 200
        case .create:
            return 201
        case .delete:
            return 204
        }
    }

}
