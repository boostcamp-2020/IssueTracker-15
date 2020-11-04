//
//  MilestoneProvider.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol MilestoneProvidable {
    func addMilestone(title: String, dueDate: String, description: String, completion: @escaping (Milestone?) -> Void)
    func editMilestone(id: Int, title: String, dueDate: String, description: String, openIssuesLength: String, closeIssueLength: String, completion: @escaping (Milestone?) -> Void)
    func fetchMilestones(completion: @escaping ([Milestone]?) -> Void)
}

class MilestoneProvider: MilestoneProvidable {
    
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
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
        print("editing : \(editingMilestone)")
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
        
        let endPoint = MilestoneEndPoint(requestType: .fetch)
        dataLoader?.request([Milestone].self, endpoint: endPoint, completion: { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        })
    }
        
}
