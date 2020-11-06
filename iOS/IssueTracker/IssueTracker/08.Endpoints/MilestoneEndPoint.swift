//
//  MilestoneEndPoint.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

class MilestoneEndPoint: IssueTrackerEndpoint {
    var parameter: String?
    
    init(requestType: IssueTrackerEndpoint.RequestType, parameter: String? = nil) {
        self.parameter = parameter
        super.init(requestType: requestType)
    }
    
    override var path: String {
        switch requestType {
        case .fetch:
            return "/api/milestone"
        case .create:
            return "/api/milestone"
        case .edit:
            return "/api/milestone/" + (parameter ?? "")
        case .delete:
            return "/api/milestone/" + (parameter ?? "")
        }
    }
}
