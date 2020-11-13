//
//  LabelEndPoint.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

enum LabelService {
    
    // [GET] /api/label
    case fetchAll
    
    // createLabel( title, description, colorCode)
    // [POST] /api/label
    case createLabel( String, String, String)
    
    // editLabel( Id, title, description, colorCode)
    // [PATCH] /api/label/:id
    case editLabel( Int, String, String, String)
    
    // deleteLabel( Id)
    // [DELETE] /api/label/:id
    case deleteLabel( Int)
}

extension LabelService: IssueTrackerService {
    
    var path: String {
        switch self {
        case .fetchAll, .createLabel:
            return "/api/label"
        case .editLabel(let id, _, _, _), .deleteLabel(let id):
            return "/api/label/\(id)"
        }
    }
    
    var queryItems: [String: String]? {
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchAll:
            return .get
        case .createLabel:
            return .post
        case .editLabel:
            return .patch
        case .deleteLabel:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .fetchAll:
            return .requestPlain
        case .createLabel(let title, let description, let colorCode):
            var jsonObject = [String: Any]()
            jsonObject["title"] = title
            jsonObject["description"] = description
            jsonObject["color"] = colorCode
            return .requestJsonObject(jsonObject)
        case .editLabel(_, let title, let description, let colorCode):
            var jsonObject = [String: Any]()
            jsonObject["title"] = title
            jsonObject["description"] = description
            jsonObject["color"] = colorCode
            return .requestJsonObject(jsonObject)
        case .deleteLabel:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchAll:
            return .successCode
        case .createLabel:
            return .successCode
        case .editLabel:
            return .custom([200])
        case .deleteLabel:
            return .custom([204])
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
