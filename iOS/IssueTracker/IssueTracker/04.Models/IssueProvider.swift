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
    func addIssue(title: String, description: String, authorID: Int, milestoneID: Int?, completion:  @escaping (Issue?) -> Void )
    func editIssue(id: Int, description: String, completion:  @escaping (Issue?) -> Void)
    func editIssue(id: Int, title: String, completion: @escaping (Issue?) -> Void)
    func fetchIssues(completion: @escaping ([Issue]?) -> Void)
    
    func getIssue(at id: Int, completion: @escaping (Issue?) -> Void)
    func addLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func deleteLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void)
    func addMilestone(at id: Int, of milestone: Int, completion: @escaping (Issue?) -> Void)
    func deleteMilestone(at id: Int, completion: @escaping (Issue?) -> Void)
    func addAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
    func deleteAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void)
}

class IssueProvider: IssueProvidable {
    
    //private(set) var issues = [Issue]()
    // mock data
    // TODO: 같은 Fetch 요청이 여러번 들어왔을 겨우 completion을 배열에 넣어두었다 한 패칭에 Completion을 모두 처리해주는 방식으로!
    private var onFetching: Bool = false
    private(set) var issues: [Issue] = [ // labels 9 ~ 17 milestone 19, 22, 23, 24, 25, 28, 36
        Issue(id: 1, title: "이슈[1]", description: "ABCDEFGH", labels: [9], milestone: 19),
        Issue(id: 2, title: "이슈[2]", description: "ABCDEFGH", labels: [10], milestone: 22),
        Issue(id: 3, title: "이슈[3]", description: "ABCDEFGH", labels: [11], milestone: 23),
        Issue(id: 4, title: "이슈[4]", description: "ABCDEFGH", labels: [12], milestone: 24),
        Issue(id: 5, title: "이슈[5]", description: "ABCDEFGH", labels: [13], milestone: 25),
        Issue(id: 6, title: "이슈[6]", description: "ABCDEFGH", labels: [14], milestone: 28),
        Issue(id: 7, title: "이슈[7]", description: "ABCDEFGH", labels: [15], milestone: 36)
    ]
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
    }
    
    func fetchIssues(completion: @escaping ([Issue]?) -> Void) {
        onFetching = true
        
        completion(issues)
        
        onFetching = false
    }
    
    func addIssue(title: String, description: String, authorID: Int, milestoneID: Int?, completion: @escaping (Issue?) -> Void) {
        let issue = Issue(id: issues.count, author: String(authorID), title: title, description: description, milestoneId: milestoneID)
        issues.append(issue)
        completion(issue)
    }
    
    func editIssue(id: Int, description: String, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        let issue = issues[idx]
        let newIssue = Issue(id: issue.id, author: issue.author, title: issue.title, description: description, milestoneId: issue.milestone)
        issues[idx] = newIssue
        completion(newIssue)
    }
    
    func editIssue(id: Int, title: String, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        let issue = issues[idx]
        let newIssue = Issue(id: issue.id, author: issue.author, title: title, description: issue.description, milestoneId: issue.milestone)
        issues[idx] = newIssue
        completion(newIssue)
    }
    
    func getIssue(at id: Int, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        completion(issues[idx])
    }
    
    func addLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        issues[idx].addLabel(id: labelId)
        completion(issues[idx])
    }
    
    func deleteLabel(at id: Int, of labelId: Int, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        issues[idx].deleteLabel(id: labelId)
        completion(issues[idx])
    }
    
    func addMilestone(at id: Int, of milestone: Int, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        issues[idx].addMilestone(id: id)
        completion(issues[idx])
    }
    
    func deleteMilestone(at id: Int, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        issues[idx].deleteLabel(id: id)
        completion(issues[idx])
    }
    
    func addAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        issues[idx].addAssignee(id: userId)
        completion(issues[idx])
    }
    
    func deleteAsignee(at id: Int, userId: Int, completion: @escaping (Issue?) -> Void) {
        guard let idx = issues.firstIndex(where: {$0.id == id}) else { completion(nil); return }
        issues[idx].deleteAssignee(id: userId)
        completion(issues[idx])
    }
        
}
