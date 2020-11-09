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
    var openedIssueNum: String
    var closedIssueNum: String
    let dueDate: String
    
    init(id: Int, title: String, description: String, dueDate: String, openIssuesLength: String, closeIssueLength: String) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.openedIssueNum = openIssuesLength
        self.closedIssueNum = closeIssueLength
    }
    
    init(title: String, description: String, dueDate: String) {
        self.id = -1
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.openedIssueNum = "0"
        self.closedIssueNum = "0"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DeCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        openedIssueNum = try container.decode(String.self, forKey: .openedIssueNum)
        closedIssueNum = try container.decode(String.self, forKey: .closedIssueNum)
        dueDate = (try? container.decode(String.self, forKey: .dueDate)) ?? ""
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
    
    enum DeCodingKeys: CodingKey {
        case id
        case title
        case description
        case openedIssueNum
        case closedIssueNum
        case dueDate
    }
}
