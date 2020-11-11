//
//  User.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/11.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let name: String
    let imageUrl: String?
    
    init(id: Int) {
        self.id = id
        name = String(id)
        imageUrl = nil
    }
    
    init(name: String, imageUrl: String? = nil) {
        // TODO: userID
        self.id = 0
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init?(json: [String: Any]) {
        guard let name = json["userName"] as? String else { return nil }
        self.id = 0
        self.name = name
        self.imageUrl = json["imageURL"] as? String
    }
}
