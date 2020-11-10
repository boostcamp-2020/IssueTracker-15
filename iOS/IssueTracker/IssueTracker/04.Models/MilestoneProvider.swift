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
    var milestons: [Int: Milestone] { get }
    
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
    private(set) var milestons = [Int: Milestone]()
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
    }
    
    func getMilestone(at id: Int, completion: @escaping (Milestone?) -> Void) {
        if milestons.contains(where: { $0.key == id }) {
            completion(milestons[id])
            return
        }
        
        // TODO : fetch 함수 분리하기
        fetchMilestones { [weak self] _ in
            if let milestone = self?.milestons[id] {
                completion(milestone)
                return
            }
            completion(nil)
        }
    }
    
    func addMilestone(title: String, dueDate: String, description: String, completion: @escaping (Milestone?) -> Void) {
        
        dataLoader?.request(MilestoneService.createMilestone(title, dueDate, description), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                guard let `self` = self,
                    let milestone = response.mapEncodable(Milestone.self)
                    else {
                        completion(nil)
                        return
                }
                self.milestons[milestone.id] = milestone
                completion(milestone)
            }
        })
        
    }
    
    func editMilestone(id: Int, title: String, dueDate: String, description: String, openIssuesLength: String, closeIssueLength: String, completion: @escaping (Milestone?) -> Void) {
        
        dataLoader?.request(MilestoneService.editMilestone(id, title, dueDate, description), callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                let milestone = Milestone(id: id, title: title, description: description, dueDate: dueDate, openIssuesLength: openIssuesLength, closeIssueLength: closeIssueLength)
                completion(milestone)
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
        
        dataLoader?.request(MilestoneService.fetchAll, callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                if let milestones = response.mapEncodable([Milestone].self) {
                    self.milestons = milestones.reduce(into: [:]) { $0[$1.id] = $1 }
                    self.fetchingCompletionHandlers.forEach {
                        $0.value(milestones)
                    }
                }
            }
            
            self.fetchingCompletionHandlers.removeAll()
            self.onFetching = false
        })
        
    }
    
}
