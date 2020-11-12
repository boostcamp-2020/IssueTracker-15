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
    var title: String
    var description: String?
    
    // TODO: author -> id!
    let author: User
    var isOpened: Bool
    let createdAt: String
    var updatedAt: String
    
    var milestone: Int?
    var labels: [Int]
    
    // TODO: user를 fetch 하는 기능이 완성되면 Int로 아이디 값을 저장할 것!
    var assignees: [User]
    
    var comments: [Comment]
    
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
    
    mutating func deleteMilestone() {
        milestone = nil
    }
    
    mutating func addAssignee(id: Int) {
        // TODO: Assignee -> [id]
        if assignees.contains(where: { $0.userName == String(id) }) { return }
        assignees.append(User(id: id))
    }
    
    mutating func deleteAssignee(id: Int) {
        guard let idx = assignees.firstIndex(where: { $0.userName == String(id) }) else { return }
        assignees.remove(at: idx)
    }
    
}

// MARK: - Hashable

extension Issue: Hashable {
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Parse From API Response

extension Issue {
    
    // from fetchIssue API
    init(id: Int,
         title: String,
         description: String? = nil,
         author: User,
         isOpened: Bool,
         createdAt: String,
         updatedAt: String,
         milestone: Int?,
         labels: [Int],
         assignees: [User]) {
        self.id = id
        self.title = title
        self.description = description
        self.author = author
        self.isOpened = isOpened
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.milestone = milestone
        self.labels = labels
        self.assignees = assignees
        self.comments = []
    }
    
    static func fetchResponse(jsonArr: [[String: Any]]?) -> [Issue]? {
        return jsonArr?.compactMap { Issue.fetchResponse(jsonObject: $0) }
    }
    
    static func fetchResponse(jsonObject: [String: Any]?) -> Issue? {
        guard let jsonObject = jsonObject,
            let id = jsonObject["id"] as? Int,
            let title = jsonObject["title"] as? String,
            let isOpened = jsonObject["isOpened"] as? Bool,
            let createdAt = jsonObject["createAt"] as? String,
            let updatedAt = jsonObject["updateAt"] as? String,
            let authorObject = jsonObject["author"] as? [String: Any],
            let author = User(json: authorObject),
            let labelObjects = jsonObject["labels"] as? [[String: Any]],
            let assigneeObjects = jsonObject["assignees"] as? [[String: Any]]
            else { return nil }
        let labels = labelObjects.compactMap { $0["id"] as? Int }
        let assignees = assigneeObjects.compactMap { User(json: $0) }
        let milestone = jsonObject["milestoneId"] as? Int
        
        return Issue(id: id, title: title, description: nil, author: author, isOpened: isOpened, createdAt: createdAt, updatedAt: updatedAt, milestone: milestone, labels: labels, assignees: assignees)
    }
    
    // from AddIssue API
    init(id: Int,
         title: String,
         description: String? = nil,
         authorId: Int,
         isOpened: Bool,
         createdAt: String,
         updatedAt: String,
         milestone: Int? ) {
        self.id = id
        self.title = title
        self.description = description
        self.author = User(id: authorId)
        self.isOpened = isOpened
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.milestone = milestone
        self.labels = []
        self.assignees = []
        self.comments = []
    }
    
    static func addResponse(jsonObject: [String: Any]?) -> Issue? {
        guard let jsonObject = jsonObject,
            let id = jsonObject["id"] as? Int,
            let title = jsonObject["title"] as? String,
            let isOpened = jsonObject["isOpened"] as? Bool,
            let createAt = jsonObject["createAt"] as? String,
            let updateAt = jsonObject["updateAt"] as? String,
            let authorId = jsonObject["authorId"] as? Int
            else { return nil }
        
        let milestoneId = jsonObject["milestoneId"] as? Int
        var description: String?
        if let desc = (jsonObject["description"] as? String) {
            description = desc.isEmpty ? nil : desc
        }
        
        return Issue(id: id, title: title, description: description, authorId: authorId, isOpened: isOpened, createdAt: createAt, updatedAt: updateAt, milestone: milestoneId)
    }
    
    // from getIssue API
    static func getResponse(jsonObject: [String: Any]?) -> Issue? {
        guard let jsonObject = jsonObject,
            let id = jsonObject["id"] as? Int,
            let title = jsonObject["title"] as? String,
            let isOpened = jsonObject["isOpened"] as? Bool,
            let createAt = jsonObject["createAt"] as? String,
            let updateAt = jsonObject["updateAt"] as? String,
            let authorObject = jsonObject["author"] as? [String: Any],
            let author = User(json: authorObject),
            let labelObjects = jsonObject["labels"] as? [[String: Any]],
            let assigneeObjects = jsonObject["assignees"] as? [[String: Any]],
            let commentObjects = jsonObject["comments"] as? [[String: Any]]
            else { return nil }
        
        var description: String?
        if let desc = (jsonObject["description"] as? String) {
            description = desc.isEmpty ? nil : desc
        }
        
        let milestoneId = (jsonObject["milestone"] as? [String: Any])?["id"] as? Int
        let labels = labelObjects.compactMap { $0["id"] as? Int }
        
        let assignees = assigneeObjects.compactMap { User(json: $0) }
        let comments = commentObjects.compactMap { Comment(json: $0) }
        
        return Issue(id: id, title: title, description: description, author: author, isOpened: isOpened, createdAt: createAt, updatedAt: updateAt, milestone: milestoneId, labels: labels, assignees: assignees, comments: comments)
    }
    
}
