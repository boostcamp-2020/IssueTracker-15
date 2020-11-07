//
//  MilestoneEndPoint.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

enum MilestoneService {
    
    // [GET] /api/milestone
    case fetchAll
    
    // getMilestone( Int)
    // [GET] /api/milestone/:id
    case getMilestone( Int)
    
    // createMilestone( title, dueDate, description)
    // [POST] /api/milestone
    case createMilestone( String, String?, String?)
    
    // editMilestone ( Id, title, dueDate, description)
    // [PATCH] /api/milestone/:id
    case editMilestone( Int, String, String?, String?)
    
    // deleteMilestone ( Id)
    // [DELETE] /api/milestone/:id
    case deleteMilestone( Int)
}

extension MilestoneService: IssueTrackerService {
    
    var path: String {
        switch self {
        case .fetchAll:
            return "/api/milestone"
        case .getMilestone(let id):
            return "/api/milestone/\(id)"
        case .createMilestone:
            return "/api/milestone"
        case .editMilestone(let id, _, _, _):
            return "/api/milestone/\(id)"
        case .deleteMilestone(let id):
            return "/api/milestone/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchAll, .getMilestone:
            return .get
        case .createMilestone:
            return .post
        case .editMilestone:
            return .patch
        case .deleteMilestone:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .fetchAll:
            return .requestPlain
        case .getMilestone:
            return .requestPlain
        case .createMilestone(let title, let dueDate, let description):
            var jsonObject = [String: Any]()
            jsonObject["title"] = title
            jsonObject["description"] = description
            jsonObject["dueDate"] = dueDate
            return .requestJsonObject(jsonObject)
        case .editMilestone(_, let title, let dueDate, let description):
            var jsonObject = [String: Any]()
            jsonObject["title"] = title
            jsonObject["description"] = description
            jsonObject["dueDate"] = dueDate
            return .requestJsonObject(jsonObject)
        case .deleteMilestone:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchAll:
            return .custom([200])
        case .getMilestone:
            return .successCode
        case .createMilestone:
            return .custom([201])
        case .editMilestone:
            return .custom([201])
        case .deleteMilestone:
            return .custom([204])
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
