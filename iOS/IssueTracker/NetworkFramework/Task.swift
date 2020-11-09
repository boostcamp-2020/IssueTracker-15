//
//  Task.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public enum Task {
    // request with no data
    case requestPlain
    // request with JsonObject Data { "key": Data, ... }
    case requestJsonObject([String: Any])
    // request with JsonCodable Data -> Encodable -> Json
    case requestJsonCodable(Encodable)
}
