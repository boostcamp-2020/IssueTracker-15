//
//  IssueEndPoint.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

class IssueEndPoint: IssueTrackerEndpoint {
    var parameter: String?

    init(requestType: IssueTrackerEndpoint.RequestType, parameter: String? = nil) {
        self.parameter = parameter
        super.init(requestType: requestType)
    }
    
    override var path: String {
        switch requestType {
        case .fetch:
            // TODO: 올바른 파라미터를 입력할 수 있도록 할 것!
            return "/api/issue?isOpend={true}"
        case .create:
            return "/api/issue"
        case .edit:
            return "/api/issue/" + (parameter ?? "")
        case .delete:
            return "/api/issue/" + (parameter ?? "")
        }
    }
    
}
