//
//  LabelEndPoint.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

class LabelEndPoint: IssueTrackerEndpoint {
    var parameter: String?

    init(requestType: IssueTrackerEndpoint.RequestType, parameter: String? = nil) {
        self.parameter = parameter
        super.init(requestType: requestType)
    }
    
    override var path: String {
        switch requestType {
        case .fetch:
            return "/api/label"
        case .create:
            return "/api/label"
        case .edit:
            return "/api/label/" + (parameter ?? "")
        case .delete:
            return "/api/label/" + (parameter ?? "")
        }
    }
    
}
