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
    let author: User
    let isOpened: Bool
    let createdAt: String
    let updatedAt: String
    
    var milestone: Int?
    var labels: [Int]
    
    var assignees: [User]
    
    var comments: [Comment]
    
    init(id: Int, author: String, title: String, description: String? = nil, milestoneId: Int? = nil) {
        self.id = id
        self.title = title
        self.author = User(name: author)
        self.milestone = milestoneId
        self.description = description ?? ""
        self.createdAt = ""
        self.updatedAt = ""
        self.labels = []
        self.assignees = []
        self.isOpened = true
        self.comments = []
    }
    
    // TODO: mock init 삭제할 것!
    init(id: Int, title: String, description: String, labels: [Int], milestone: Int? = nil, author: String, isOpened: Bool) {
        self.id = id
        self.title = title
        self.author = User(name: author)
        self.milestone = milestone
        self.description = description
        self.createdAt = ""
        self.updatedAt = ""
        self.labels = labels
        self.assignees = []
        self.isOpened = true
        self.comments = []
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

// MARK: - Parse From API Response

extension Issue {
    
    // from fetchIssue API
    init(id: Int,
         title: String,
         description: String,
         author: String,
         isOpened: Bool,
         createdAt: String,
         updatedAt: String,
         milestone: Int?,
         labels: [Int],
         assignees: [User]) {
        self.id = id
        self.title = title
        self.description = description
        self.author = User(name: author)
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
            let authorObject = jsonObject["author"] as? [String:Any],
            let author = authorObject["userName"] as? String,
            let labelObjects = jsonObject["labels"] as? [[String: Any]],
            let assigneeObjects = jsonObject["assignees"] as? [[String: Any]]
            else { return nil }
        let labels = labelObjects.compactMap { $0["id"] as? Int }
        let assignees = assigneeObjects.compactMap { User(json: $0) }
        let description = ""
        let milestone = jsonObject["milestoneId"] as? Int
        
        return Issue(id: id, title: title, description: description, author: author, isOpened: isOpened, createdAt: createdAt, updatedAt: updatedAt, milestone: milestone, labels: labels, assignees: assignees)
    }
    
    // from AddIssue API
    init(id: Int,
         title: String,
         description: String,
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
        let description = (jsonObject["description"] as? String) ?? ""
        let milestoneId = jsonObject["milestoneId"] as? Int
        
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
            let authorName = authorObject["userName"] as? String,
            let labelObjects = jsonObject["labels"] as? [[String: Any]],
            let assigneeObjects = jsonObject["assignees"] as? [[String: Any]],
            let commentObjects = jsonObject["comments"] as? [[String: Any]]
            else { return nil }
        let description = (jsonObject["description"] as? String) ?? ""
        let milestoneId = (jsonObject["milestone"] as? [String: Any])?["id"] as? Int
        let labels = labelObjects.compactMap { $0["id"] as? Int }
        let authorImageUrl = authorObject["imageURL"] as? String
        
        let author = User(name: authorName, imageUrl: authorImageUrl)
        let assignees = assigneeObjects.compactMap { User(json: $0) }
        let comments = commentObjects.compactMap { Comment(json: $0) }
        
        return Issue(id: id, title: title, description: description, author: author, isOpened: isOpened, createdAt: createAt, updatedAt: updateAt, milestone: milestoneId, labels: labels, assignees: assignees, comments: comments)
    }
    
    init(id: Int,
         title: String,
         description: String,
         author: User,
         isOpened: Bool,
         createdAt: String,
         updatedAt: String,
         milestone: Int?,
         labels: [Int],
         assignees: [User],
         comments: [Comment]) {
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
        self.comments = comments
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
    
    init(name: String, imageUrl: String? = nil) {
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init?(json: [String: Any]) {
        guard let name = json["userName"] as? String else { return nil }
        self.name = name
        self.imageUrl = json["imageURL"] as? String
    }
}

// TODO: Comment DataModel? <- 그냥 이슈가 들고있는게 좋나?
struct Comment {
    let content: String
    let createAt: String
    let author: User
    
    init(content: String, user: User) {
        self.content = content
        self.createAt = ""
        self.author = user
    }
    
    init?(json: [String: Any]) {
        guard let content = json["content"] as? String,
            let createAt = json["createAt"] as? String,
            let userObject = json["user"] as? [String: Any],
            let user = User(json: userObject)
            else { return nil }
        self.content = content
        self.createAt = createAt
        self.author = user
    }
}
