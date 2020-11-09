//
//  CommentService.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/08.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

enum CommentService {
    
    // addComment ( issueId, comment )
    // [POST] /api/comment
    case addComment( Int, String)
    
    // editComment ( issueId, comment )
    // [PATCH] /api/comment/:id
    case editComment( Int, String)
    
    // deleteComment ( issueId)
    // [DELETE] /api/comment/:id
    case deleteComment( Int)
    
}

extension CommentService: IssueTrackerService {
    
    var path: String {
        switch self {
        case .addComment:
            return "/api/comment"
        case .editComment(let id, _):
            return "/api/comment/\(id)"
        case .deleteComment(let id):
            return "/api/comment/\(id)"
        }
    }
    
    var queryItems: [String: String]? {
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .addComment:
            return .post
        case .editComment:
            return .patch
        case .deleteComment:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .addComment(let id, let comment):
            var jsonObject = [String: Any]()
            jsonObject["issueID"] = id
            jsonObject["content"] = comment
            return .requestJsonObject(jsonObject)
        case .editComment(let id, let comment):
            var jsonObject = [String: Any]()
            jsonObject["issueID"] = id
            jsonObject["content"] = comment
            return .requestJsonObject(jsonObject)
        case .deleteComment:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .addComment:
            return .successCode
        case .editComment:
            return .successCode
        case .deleteComment:
            return .successCode
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
}
