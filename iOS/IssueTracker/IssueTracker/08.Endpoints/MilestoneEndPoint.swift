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
        case test
    }
    
    var scheme: String {
        switch self {
        default:
            #warning("실제 서버는 http")
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com"
        }
    }
    
    var path: String {
        switch requestType {
        case .fetch:
            return "/api/milestones"
        case .create:
            return "/api/milestone"
        case .edit:
            return "/api/milestone/" + parameter
        case .delete:
            return "/api/milestone/" + parameter
        case .test:
            return "/develop/baminchan/" + parameter
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
        case .test:
            return .get
        }
    }
}
