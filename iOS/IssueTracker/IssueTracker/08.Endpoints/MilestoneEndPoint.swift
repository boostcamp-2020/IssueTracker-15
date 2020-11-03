//
//  MilestoneEndPoint.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

struct MilestoneEndPoint: EndPoint {
    var requestType: RequestType
    var parameter: String = ""
    var httpBody: Data?

    init(requestType: RequestType, parameter: String, httpBody: Data? = nil) {
        self.requestType = requestType
        self.parameter = parameter
        self.httpBody = httpBody
    }
    
    init(requestType: RequestType, httpBody: Data? = nil) {
        self.requestType = requestType
        self.httpBody = httpBody
    }
    
    enum RequestType {
        case fetch
        case create
        case edit
        case delete
    }
    
    var scheme: String {
        switch self {
        default:
            return "http"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "118.67.134.194"
        }
    }
    
    var port: Int {
        switch self {
        default:
            return 3000
        }
    }
    
    var path: String {
        switch requestType {
        case .fetch:
            return "/api/milestone"
        case .create:
            return "/api/milestone"
        case .edit:
            return "/api/milestone/" + parameter
        case .delete:
            return "/api/milestone/" + parameter

        }
    }
    
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
