//
//  IssueProvider.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol IssueProvidable: AnyObject {
    
    var currentUser: User? { get }
    var users: [Int: User] { get }
    
    func fetchIssues(completion: @escaping ([Issue]?) -> Void)
    func fetchIssues(with filter: IssueFilterable?, completion: @escaping ([Issue]?) -> Void)
    
    func addIssue(title: String, description: String, milestoneID: Int?, completion:  @escaping (Issue?) -> Void )
    func editIssue(id: Int, title: String, description: String, completion:  @escaping (Issue?) -> Void)
    func editTitle(id: Int, title: String, completion: @escaping (Issue?) -> Void)
    func deleteIssue(id: Int, completion: @escaping (Issue?) -> Void)
    
    func getIssue(at id: Int, completion: @escaping (Issue?) -> Void)
    func changeIssueState(id: Int, open: Bool, completion: @escaping (Bool) -> Void)
    func addLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func deleteLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func addMilestone(at id: Int, of milestone: Int, completion: @escaping (Issue?) -> Void)
    func deleteMilestone(at id: Int, completion: @escaping (Issue?) -> Void)
    func addAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
    func deleteAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
    func addComment(issueNumber: Int, content: String, completion: @escaping (Comment?) -> Void)
    
}

class IssueProvider: IssueProvidable {
    
    private var lastUpdated: Date?
    private var needFetch: Bool {
        guard let lastUpdated = self.lastUpdated else { return true }
        let current = Date()
        let duration = Int(current.timeIntervalSince(lastUpdated))
        return duration > 30
    }
    
    private weak var dataLoader: DataLoadable?
    private weak var userProvider: UserProvidable?
    
    private(set) var issues = [Int: Issue]()
    var users: [Int: User] {
        return userProvider?.users ?? [:]
    }
    var currentUser: User? {
        userProvider?.currentUser
    }
    
    init(dataLoader: DataLoadable, userProvider: UserProvidable) {
        self.dataLoader = dataLoader
        self.userProvider = userProvider
    }
    
    func fetchIssues(completion: @escaping ([Issue]?) -> Void) {
        if !needFetch {
            completion(issues.map { $0.value })
            return
        }
        issues.removeAll()
        
        userProvider?.fetchUser { [weak self] (_) in
            let group = DispatchGroup()
            
            let fetchWork: NetworkFramework.Completion = { [weak self] (response) in
                switch response {
                case .failure:
                    break
                case .success(let response):
                    if let issues = Issue.fetchResponse(jsonArr: response.mapJsonArr()) {
                        issues.forEach {
                            self?.issues[$0.id] = $0
                        }
                    }
                }
                group.leave()
            }
            
            group.enter()
            self?.dataLoader?.request(IssueService.fetchAll(true), callBackQueue: .main, completion: fetchWork)
            group.enter()
            self?.dataLoader?.request(IssueService.fetchAll(false), callBackQueue: .main, completion: fetchWork)
            
            group.notify(queue: .main) { [weak self] in
                self?.lastUpdated = Date()
                completion(self?.issues.map { $0.value })
            }
        }
        
    }
    
    func fetchIssues(with filter: IssueFilterable?, completion: @escaping ([Issue]?) -> Void) {
        let filterWork: ([Issue]?) -> Void = { [weak self] issues in
            guard let `self` = self else {
                completion([])
                return
            }
            let issueDummy = issues ?? self.issues.map { $0.value }
            completion(filter?.filter(datas: issueDummy, user: self.currentUser))
        }
        
        if needFetch {
            fetchIssues(completion: filterWork)
        } else {
            filterWork(issues.map { $0.value })
        }
    }
        
    func addComment(issueNumber: Int, content: String, completion: @escaping (Comment?) -> Void) {
        guard let myId = userProvider?.currentUser?.id else {
            completion(nil)
            return
        }
        
        dataLoader?.request(CommentService.addComment(myId, issueNumber, content), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                guard let comment = Comment.addResponse(json: response.mapJsonObject())
                    else {
                        completion(nil)
                        return
                }
                self?.issues[issueNumber]?.comments.append(comment)
                completion(comment)
            }
        })
    }
    
    func addIssue(title: String, description: String, milestoneID: Int?, completion: @escaping (Issue?) -> Void) {
        guard let myId = userProvider?.currentUser?.id else {
            completion(nil)
            return
        }
        
        dataLoader?.request(IssueService.createIssue(title, description, milestoneID, myId), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                if let issue = Issue.addResponse(jsonObject: response.mapJsonObject()) {
                    self.issues[issue.id] = issue
                    completion(issue)
                }
            }
        })
    }
    
    func getIssue(at id: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.getIssue(id), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                if let issue = Issue.getResponse(jsonObject: response.mapJsonObject()) {
                    self?.issues[issue.id] = issue
                    issue.comments.forEach { self?.userProvider?.users[$0.author.id] = $0.author }
                    completion(issue)
                } else {
                    completion(nil)
                }
            }
        })
    }
    
    func changeIssueState(id: Int, open: Bool, completion: @escaping (Bool) -> Void) {
        dataLoader?.request(IssueService.editIssue(id, nil, nil, open), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(false)
            case .success:
                self?.issues[id]?.isOpened = open
                completion(true)
            }
        })
    }
    
    func deleteIssue(id: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.delete(id), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                let issue = self?.issues.removeValue(forKey: id)
                completion(issue)
            }
        })
    }
    
    func editIssue(id: Int, title: String, description: String, completion: @escaping (Issue?) -> Void) {
        
        dataLoader?.request(IssueService.editIssue(id, title, description, nil), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self.issues[id]?.title = title
                self.issues[id]?.description = description.isEmpty ? nil : description
                completion(self.issues[id])
            }
        })
    }
    
    func editTitle(id: Int, title: String, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.editTitle(id, title), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self.issues[id]?.title = title
                completion(self.issues[id])
            }
        })
    }
    
    func addLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.addLabel(id, labelId), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self.issues[id]?.addLabel(id: labelId)
                completion(self.issues[id])
            }
        })
    }
    
    func deleteLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.deleteLabel(id, labelId), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self.issues[id]?.deleteLabel(id: labelId)
                completion(self.issues[id])
            }
        })
    }
    
    func addMilestone(at id: Int, of milestone: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.addMilestone(id, milestone), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self.issues[id]?.addMilestone(id: milestone)
                completion(self.issues[id])
            }
        })
    }
    
    func deleteMilestone(at id: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.deleteMilestone(id, 0), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self?.issues[id]?.deleteMilestone()
                completion(self?.issues[id])
            }
        })
    }
    
    func addAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.addAssignee(id, userId), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self.issues[id]?.addAssignee(id: userId)
                completion(self.issues[id])
            }
        })
    }
    
    func deleteAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.deleteAssignee(id, userId), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                self.issues[id]?.deleteAssignee(id: userId)
                completion(self.issues[id])
            }
        })
    }
    
}
