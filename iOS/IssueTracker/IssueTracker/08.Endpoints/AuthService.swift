//
//  AuthService.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/11.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

enum AuthService {
    case github
    case server(TokenRequest)
}

extension AuthService: IssueTrackerService {
    var baseURL: URL {
        switch self {
        case .github:
            return URL(string: "https://github.com/login/oauth/authorize")!
        case .server:
            return URL(string: "http://118.67.134.194:3000")!
        }
    }
    
    var path: String {
        switch self {
        case .github:
            return ""
        case .server:
            return "/api/signin/github"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var task: Task {
        switch self {
        case .github:
            return .requestPlain
        case .server(let tokenRequest):
            return .requestJsonCodable(tokenRequest)
        }
    }
    
    var validationType: ValidationType {
        return .successCode
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .github:
            return ["client_id": "948b281c21a5ea24dfa7"]
        case .server:
            return nil
        }
    }
    
}
