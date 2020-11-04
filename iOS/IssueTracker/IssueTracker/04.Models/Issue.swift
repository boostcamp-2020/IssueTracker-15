//
//  Issue.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/01.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct Issue {
    let id: Int
    let title: String
    
    // TODO: description -> 없을 시 ""
    let description: String
    
    // TODO: author -> id!
    let author: String
    let isOpened: Bool
    let createdAt: String
    let updatedAt: String
    
    var milestone: Int?
    var labels: [Int]
    
    // TODO: asignees -> [id]
    var assignees: [User]
    
    init(id: Int, author: String, title: String, description: String? = nil, milestoneId: Int? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.milestone = milestoneId
        self.description = description ?? ""
        self.createdAt = ""
        self.updatedAt = ""
        self.labels = []
        self.assignees = []
        self.isOpened = true
    }
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
              let title = json["title"] as? String,
            let isOpened = json["isOpened"] as? Bool,
              let createdAt = json["createAt"] as? String,
              let updatedAt = json["updateAt"] as? String,
              let labels = json["labels"] as? [[String: Any]],
              let assignees = json["assignees"] as? [[String: Any]]
        else { return nil }
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isOpened = isOpened
        self.labels = labels.compactMap { $0["id"] as? Int }
        self.assignees = assignees.compactMap { User(json: $0) }
        self.description = ""
        
        self.author = (json["author"] as? String)  ?? ""
        self.milestone = json["milestoneId"] as? Int
    }
   
    mutating func addLabel(id: Int) {
        if labels.contains(where: {$0 == id}) { return }
        labels.append(id)
    }
    
    mutating func deleteLabel(id: Int) {
        guard let idx = labels.firstIndex(where: {$0 == id}) else { return }
        labels.remove(at: idx)
    }
    
    mutating func addMilestone(id: Int) {
        milestone = id
    }
    
    mutating func deleteMilestone(id: Int) {
        if milestone == id {
            milestone = nil
        }
    }
    
    mutating func addAssignee(id: Int) {
        // TODO: Assignee -> [id]
        if assignees.contains(where: { $0.name == String(id) }) { return }
        assignees.append(User(id: id))
    }
    
    mutating func deleteAssignee(id: Int) {
        guard let idx = assignees.firstIndex(where: { $0.name == String(id) }) else { return }
        assignees.remove(at: idx)
    }
}

// TODO: User DataModel
struct User {
    let name: String
    let imageUrl: String?
    
    init(id: Int) {
        name = String(id)
        imageUrl = nil
    }
    
    init?(json: [String: Any]) {
        guard let name = json["userName"] as? String else { return nil }
        self.name = name
        self.imageUrl = json["imageURL"] as? String
    }
}
