//
//  Milestone.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct Milestone: Codable {
    let id: Int
    let title: String
    let description: String
    let openIssuesLength: String
    let closeIssueLength: String
    let dueDate: String
    
    init(id: Int, title: String, description: String, dueDate: String, openIssuesLength: String, closeIssueLength: String) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.openIssuesLength = openIssuesLength
        self.closeIssueLength = closeIssueLength
    }
    
    init(id: Int, title: String, description: String, dueDate: String) {
        self.init(id: id, title: title, description: description, dueDate: dueDate, openIssuesLength: "0", closeIssueLength: "0")
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DeCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        openIssuesLength = try container.decode(String.self, forKey: .openIssueLength)
        closeIssueLength = try container.decode(String.self, forKey: .closeIssueLength)
        dueDate = try container.decode(String.self, forKey: .dueDate)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnCodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(dueDate, forKey: .dueDate)
    }
    
    enum EnCodingKeys: CodingKey {
        case title
        case dueDate
        case description
    }
    
    enum DeCodingKeys: String, CodingKey {
        case id
        case title
        case description
        case openIssueLength = "OpenIssuesLength"
        case closeIssueLength = "CloseIssuesLength"
        case dueDate
    }
}
