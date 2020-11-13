//
//  User.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/11.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let userName: String
    let imageURL: String?
    
    init(id: Int) {
        self.id = id
        userName = String(id)
        imageURL = nil
    }
    
}

// MARK: - For Common Response Data

extension User {
    
    init?(json: [String: Any]) {
        guard let name = json["userName"] as? String,
              let id = json["id"] as? Int
        else { return nil }
        self.id = id
        self.userName = name
        self.imageURL = json["imageURL"] as? String
    }
    
    static func fetchResponse(json: [String: Any]?) -> [User]? {
        guard let userJsonArr = json?["userList"] as? [[String: Any]] else { return nil }
        return userJsonArr.compactMap { User(json: $0) }
    }
    
}
