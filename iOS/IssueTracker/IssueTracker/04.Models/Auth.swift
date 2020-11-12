//
//  Auth.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

enum LoginResult {
    case success
    case failure
}

struct TokenResponse: Codable {
    let accessToken: String
    let user: User
}

struct TokenRequest: Encodable {
    let type: String
    let code: String
}
