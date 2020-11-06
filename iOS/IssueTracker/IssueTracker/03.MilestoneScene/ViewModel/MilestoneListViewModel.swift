//
//  MilestoneListViewModel.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol MilestoneListViewModelProtocol: AnyObject {
    var didFetch: (() -> Void)? { get set }
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> MilestoneItemViewModel
    func numberOfItem() -> Int
    func addNewMileStone(title: String, dueDate: String, description: String)
    func editMileStone(at indexPath: IndexPath, title: String, description: String, dueDate: String)
}

class MilestoneListViewModel: MilestoneListViewModelProtocol {
    var didFetch: (() -> Void)?
    private var milestones = [MilestoneItemViewModel]()
    private var milestoneProvider: MilestoneProvidable?
    
    init(with milestoneProvider: MilestoneProvidable) {
        self.milestoneProvider = milestoneProvider
    }
    
    func addNewMileStone(title: String, dueDate: String, description: String) {
        
        milestoneProvider?.addMilestone(title: title, dueDate: dueDate, description: description, completion: { [weak self] (milestone) in
            guard let `self` = self,
            let milestone = milestone
                else { return }
            self.milestones.insert(MilestoneItemViewModel(milestone: milestone, from: .fromServer), at: 0)
            DispatchQueue.main.async {
                self.didFetch?()
            }
        })
    }
    
    func editMileStone(at indexPath: IndexPath, title: String, description: String, dueDate: String) {
        let currentMilestone: MilestoneItemViewModel = milestones[indexPath.row]
        
        milestoneProvider?.editMilestone(id: currentMilestone.id, title: title, dueDate: dueDate, description: description, openIssuesLength: currentMilestone.openIssue, closeIssueLength: currentMilestone.closedIssue) { [weak self] (milestone) in
            guard let `self` = self,
                let milestone = milestone
                else { return }
            // print("listviewModel completion: \(milestone)")
            self.milestones[indexPath.row] = MilestoneItemViewModel(milestone: milestone, from: .fromSubmitView)
            DispatchQueue.main.async {
                self.didFetch?()
            }
        }
    }
    
    func needFetchItems() {
        milestoneProvider?.fetchMilestones { [weak self] (milestones) in
            guard let `self` = self,
                let milestones = milestones
                else { return }
            milestones.forEach { self.milestones.append(MilestoneItemViewModel(milestone: $0, from: .fromServer)) }
            DispatchQueue.main.async {
                // print("datasource: \(self.milestones)")
                self.didFetch?()
            }
        }
    }
    
    func cellForItemAt(path: IndexPath) -> MilestoneItemViewModel {
        return milestones[path.row]
    }
    
    func numberOfItem() -> Int {
        milestones.count
    }
}
