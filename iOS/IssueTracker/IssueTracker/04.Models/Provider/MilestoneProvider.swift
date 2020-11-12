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
    
    private(set) var milestons = [Int: Milestone]()
    private weak var dataLoader: DataLoadable?
    private weak var userProvider: UserProvidable?
    
    private var onFetching = false
    private var fetchingCompletionHandlers = [Int: ([Milestone]?)->Void]()
    
    init(dataLoader: DataLoadable, userProvider: UserProvidable) {
        self.dataLoader = dataLoader
        self.userProvider = userProvider
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
        
        dataLoader?.request(MilestoneService.editMilestone(id, title, dueDate, description), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                let milestone = Milestone(id: id, title: title, description: description, dueDate: dueDate, openIssuesLength: openIssuesLength, closeIssueLength: closeIssueLength)
                self?.milestons[id] = milestone
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
