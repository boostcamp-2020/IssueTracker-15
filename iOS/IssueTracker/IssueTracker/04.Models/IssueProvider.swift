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
    
    var users: [Int: User] { get }
}

class IssueProvider: IssueProvidable {
    
    private var lastUpdated: Date?
    private var needFetch: Bool {
        guard let lastUpdated = self.lastUpdated else { return true }
        let current = Date()
        let duration = Int(current.timeIntervalSince(lastUpdated))
        // TODO: default 시간 차 구하기
        return duration > 60 * 1
    }
    
    private weak var dataLoader: DataLoadable?
    private weak var userProvider: UserProvidable?
    
    private(set) var issues = [Int: Issue]()
    var users: [Int: User] {
        return userProvider?.users ?? [:]
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
        
        let group = DispatchGroup()
        
        let fetchWork: NetworkFramework.Completion = { [weak self] (response) in
            switch response {
            case .failure:
                break
            case .success(let response):
                if let issues = Issue.fetchResponse(jsonArr: response.mapJsonArr()) {
                    issues.forEach {
                        self?.issues[$0.id] = $0
                        self?.userProvider?.users[$0.author.id] = $0.author
                        $0.assignees.forEach { self?.userProvider?.users[$0.id] = $0 }
                    }
                }
            }
            group.leave()
        }
        
        group.enter()
        dataLoader?.request(IssueService.fetchAll(true), callBackQueue: .global(), completion: fetchWork)
        group.enter()
        dataLoader?.request(IssueService.fetchAll(false), callBackQueue: .global(), completion: fetchWork)
        
        group.notify(queue: .main) { [weak self] in
            self?.lastUpdated = Date()
            completion(self?.issues.map { $0.value })
        }
    }
    
    func fetchIssues(with filter: IssueFilterable?, completion: @escaping ([Issue]?) -> Void) {
        let filterWork: ([Issue]?) -> Void = { [weak self] issues in
            guard let `self` = self else {
                completion([])
                return
            }
            let issueDummy = issues ?? self.issues.map { $0.value }
            completion(filter?.filter(datas: issueDummy))
        }
        
        if needFetch {
            fetchIssues(completion: filterWork)
        } else {
            filterWork(issues.map { $0.value })
        }
    }
    
    /*
     Response :
     */
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
    
    /*
     Response : 201
     */
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
    /*
     Response: 200
     */
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
    
    /*
     Response : 200 body: nil
     */
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
    
    /*
     Response : 200 body: nil
     */
    func editTitle(id: Int, title: String, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.editTitle(id, title), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
            //TODO: response 처리
            break
            }
        })
    }
    
    /*
     response: 201 body : nil
     */
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
    /*
     response: 204 body: nil
     */
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
    
    /*
     response: 201
     */
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
    
    /*
     response: 204
     */
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
    /*
     response: 201
     */
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
    /*
     response: 204
     */
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
