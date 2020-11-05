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
        Issue(id: 1, title: "댓글 추가화면 개선", description: "현재 버튼만 생성되었음", labels: [9], milestone: 19, author: "JK", isOpened: true),
        Issue(id: 2, title: "이슈 상세화면 UI 틀 잡기", description: "상세화면 dynamic sizing 적용하기", labels: [10], milestone: 22, author: "JK", isOpened: false),
        Issue(id: 3, title: "네트워크 모델 설계", description: "네트워크 부분 프레임워크로 분리하기", labels: [11], milestone: 23, author: "JK", isOpened: true),
        Issue(id: 4, title: "마일스톤 API PATCH 부분 수정", description: "API 수정", labels: [12], milestone: 24, author: "JK", isOpened: false),
        Issue(id: 5, title: "이슈 수정/추가 화면에서 마크다운 문법 지원 -> 렌더링 하여 미리보기 기능 구현하기", description: "마크다운 렌더링 방법 알아보기 (pod 사용도 고려)", labels: [13], milestone: 25, author: "JK", isOpened: true),
        Issue(id: 6, title: "MilestoneHeader, MileStoneSubmitForm 연결하고 xib Autolayout 조정하기", description: "xib의 발음은 nib", labels: [14], milestone: 28, author: "JK", isOpened: false),
        Issue(id: 7, title: "Issue/Label/Milestone Provider 설계", description: "네트워크 통신은 Provider가 담당하도록 설계", labels: [15], milestone: 36, author: "JK", isOpened: true)
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
