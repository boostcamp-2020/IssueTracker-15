//
//  MilestoneProvider.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol MilestoneProvidable: AnyObject {
    var milestons: [Milestone] { get }
    
    func addMilestone(title: String, dueDate: String, description: String, completion: @escaping (Milestone?) -> Void)
    func editMilestone(id: Int, title: String, dueDate: String, description: String, openIssuesLength: String, closeIssueLength: String, completion: @escaping (Milestone?) -> Void)
    func fetchMilestones(completion: @escaping ([Milestone]?) -> Void)
    
    func getMilestone(at id: Int, completion: @escaping (Milestone?) -> Void)
}

class MilestoneProvider: MilestoneProvidable {
    
    // TODO: 같은 Fetch 요청이 여러번 들어왔을 겨우 completion을 배열에 넣어두었다 한 패칭에 Completion을 모두 처리해주는 방식으로!
    // 추상화 단계를 한단계 올릴지 생각해 볼것!
    private var onFetching = false
    // Key, Value(CompletionFunc) 로 관리하고 처리 됬을 경우 삭제해주기!
    // 효율적인 key 관리 기법 생각해보기!
    private var fetchingCompletionHandlers = [Int: ([Milestone]?)->Void]()
    private(set) var milestons = [Milestone]()
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
    }
    
    func getMilestone(at id: Int, completion: @escaping (Milestone?) -> Void) {
        if let idx = milestons.firstIndex(where: {$0.id == id}) {
            completion(milestons[idx])
            return
        }
        
        // TODO : fetch 함수 분리하기
        fetchMilestones { [weak self] _ in
            if let mileston = self?.milestons.first(where: {$0.id == id}) {
                completion(mileston)
                return
            }
            completion(nil)
        }
    }
    
    func addMilestone(title: String, dueDate: String, description: String, completion: @escaping (Milestone?) -> Void) {
        
        let endPoint = MilestoneEndPoint(requestType: .create)
        let addingMilestone = Milestone(title: title, description: description, dueDate: dueDate)
        endPoint.httpBody = JSONEncoder.encode(data: addingMilestone)
        
        dataLoader?.request(Milestone.self, endpoint: endPoint, completion: { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        })
    }
    
    func editMilestone(id: Int, title: String, dueDate: String, description: String, openIssuesLength: String, closeIssueLength: String, completion: @escaping (Milestone?) -> Void) {
        
        let endPoint = MilestoneEndPoint(requestType: .edit, parameter: String(id))
        let editingMilestone = Milestone(id: id, title: title, description: description, dueDate: dueDate, openIssuesLength: openIssuesLength, closeIssueLength: closeIssueLength)
        endPoint.httpBody = JSONEncoder.encode(data: editingMilestone)
        
        dataLoader?.request(Milestone.self, endpoint: endPoint, completion: { (result) in
            switch result {
            case .success:
                completion(editingMilestone)
            case .failure:
                completion(nil)
            }
        })
    }
    
    func fetchMilestones(completion: @escaping ([Milestone]?) -> Void) {
        if onFetching {
            fetchingCompletionHandlers[fetchingCompletionHandlers.count] = completion
            return
        }
        
        onFetching = true
        fetchingCompletionHandlers[fetchingCompletionHandlers.count] = completion
        let endPoint = MilestoneEndPoint(requestType: .fetch)
        dataLoader?.request([Milestone].self, endpoint: endPoint, completion: { (result) in
            switch result {
            case .success(let data):
                if let data = data { self.milestons = data }
                self.fetchingCompletionHandlers.forEach {
                    $0.value(data)
                }
            case .failure:
                completion(nil)
            }
            
            self.fetchingCompletionHandlers.removeAll()
            self.onFetching = false
        })
    }
        
}
