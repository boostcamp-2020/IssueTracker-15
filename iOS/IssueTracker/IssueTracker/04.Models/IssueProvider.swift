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
    
    func addIssue(title: String, description: String, authorID: Int, milestoneID: Int?, completion:  @escaping (Issue?) -> Void )
    func editIssue(id: Int, title: String, description: String, completion:  @escaping (Issue?) -> Void)
    func editTitle(id: Int, title: String, completion: @escaping (Issue?) -> Void)
    
    func getIssue(at id: Int, completion: @escaping (Issue?) -> Void)
    func changeIssueState(id: Int, open: Bool, completion: @escaping (Bool) -> Void)
    func addLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func deleteLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func addMilestone(at id: Int, of milestone: Int, completion: @escaping (Issue?) -> Void)
    func deleteMilestone(at id: Int, completion: @escaping (Issue?) -> Void)
    func addAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
    func deleteAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
    func addComment(issueNumber: Int, content: String, completion: @escaping (Bool) -> Void)
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
    
    // mock data
    private(set) var issues: [Int: Issue] = [ // labels 9 ~ 17 milestone 19, 22, 23, 24, 25, 28, 36
        1: Issue(id: 1, title: "이슈[1]", description: "ABCDEFGH", labels: [9], milestone: 19, author: "JK", isOpened: true),
        2: Issue(id: 2, title: "이슈[2]", description: "ABCDEFGH", labels: [10], milestone: 22, author: "JK", isOpened: true),
        3: Issue(id: 3, title: "이슈[3]", description: "ABCDEFGH", labels: [11], milestone: 23, author: "JK", isOpened: true),
        4: Issue(id: 4, title: "이슈[4]", description: "ABCDEFGH", labels: [12], milestone: 24, author: "JK", isOpened: true),
        5: Issue(id: 5, title: "이슈[5]", description: "ABCDEFGH", labels: [13], milestone: 25, author: "JK", isOpened: true),
        6: Issue(id: 6, title: "이슈[6]", description: "ABCDEFGH", labels: [14], milestone: 28, author: "JK", isOpened: true),
        7: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true),
        8: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true),
        9: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true),
        10: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true),
        11: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true),
        12: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true),
        13: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true),
        14: Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36, author: "JK", isOpened: true)
    ]
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
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
            fetchIssues(completion: filterWork)
        }
    }
    
    /*
     Response :
     */
    func addComment(issueNumber: Int, content: String, completion: @escaping (Bool) -> Void) {
        dataLoader?.request(CommentService.addComment(1, issueNumber, content), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(false)
            case .success:
                completion(true)
            }
        })
    }
    
    /*
     Response : 201
     */
    func addIssue(title: String, description: String, authorID: Int, milestoneID: Int?, completion: @escaping (Issue?) -> Void) {
        dataLoader?.request(IssueService.createIssue(title, description, milestoneID, authorID), callBackQueue: .main, completion: { (response) in
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
        dataLoader?.request(IssueService.getIssue(id), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                if let issue = Issue.getResponse(jsonObject: response.mapJsonObject()) {
                    completion(issue)
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
                // TODO: response 처리
                break
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
                // TODO response 처리
                break
            }
        })
    }
        
}
