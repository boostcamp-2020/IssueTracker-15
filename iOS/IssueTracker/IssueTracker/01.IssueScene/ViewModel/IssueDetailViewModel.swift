//
//  IssueDetailViewModel.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol IssueDetailViewModelProtocol: AnyObject {
    var issueNumber: Int { get }
    var title: String { get }
    var author: UserViewModel { get }
    var isOpened: Bool { get }
    var didFetch: (() -> Void)? { get set }
    var milestone: MilestoneItemViewModel? { get }
    var headerViewModel: IssueDetailHeaderViewModel { get }
    var description: String? { get }
    var comments: [CommentViewModel] { get }
    var labels: [LabelItemViewModel] { get }
    var assignees: [UserViewModel] { get }
    func needFetchDetails()
    func addComment(content: String)
    func editIssue(title: String, description: String)
    func toggleIssueState()
    
    var didLabelChanged: (() -> Void)? { get set }
    var didMilestoneChanged: (() -> Void)? { get set }
    var didAssigneeChanged: (() -> Void)? { get set }
    
    func detailSelectionItemDataSource(of type: DetailSelectionType) -> [[CellComponentViewModel]]
    func detailItemSelected(type: DetailSelectionType, selectedItems: [CellComponentViewModel])
}

class IssueDetailViewModel: IssueDetailViewModelProtocol {
    
    var issueNumber: Int = 0
    var title: String = ""
    var author: UserViewModel = UserViewModel()
    var didFetch: (() -> Void)?
    var isOpened: Bool = false
    var description: String?
    var milestone: MilestoneItemViewModel?
    var comments: [CommentViewModel] = [CommentViewModel]()
    var labels: [LabelItemViewModel] = [LabelItemViewModel]()
    var assignees: [UserViewModel] = [UserViewModel]()
    
    var headerViewModel: IssueDetailHeaderViewModel {
        IssueDetailHeaderViewModel(id: issueNumber, title: title, author: author, isOpened: isOpened)
    }
    
    var didLabelChanged: (() -> Void)?
    var didMilestoneChanged: (() -> Void)?
    var didAssigneeChanged: (() -> Void)?
    
    private weak var issueProvider: IssueProvidable?
    private weak var labelProvier: LabelProvidable?
    private weak var milestoneProvider: MilestoneProvidable?
    
    init(id: Int, issueProvider: IssueProvidable?, labelProvier: LabelProvidable?, milestoneProvider: MilestoneProvidable?) {
        self.issueNumber = id
        self.issueProvider = issueProvider
        self.labelProvier = labelProvier
        self.milestoneProvider = milestoneProvider
    }
    
    func needFetchDetails() {
        issueProvider?.getIssue(at: issueNumber) { [weak self] (issue) in
            guard let `self` = self,
                let issueProvider = self.issueProvider,
                let currentIssue = issue,
                let author = issueProvider.users[currentIssue.author]
                else { return }
            
            self.issueNumber = currentIssue.id
            self.title = currentIssue.title
            self.isOpened = currentIssue.isOpened
            self.author = UserViewModel(user: author)
            
            if let description = currentIssue.description {
                self.description = description
                self.comments.append(CommentViewModel(comment: Comment(content: description, user: author)))
            }
            
            currentIssue.comments.forEach { comment in
                self.comments.append(CommentViewModel(comment: comment))
            }
            
            self.labelProvier?.getLabels(of: currentIssue.labels) { (labels) in
                self.labels = labels.map { LabelItemViewModel(label: $0)}
                self.didLabelChanged?()
            }
            
            if let milestoneId = currentIssue.milestone {
                self.milestoneProvider?.getMilestone(at: milestoneId) { (milestone) in
                    guard let milestone = milestone else { return }
                    self.milestone = MilestoneItemViewModel(milestone: milestone, from: .fromServer)
                    self.didMilestoneChanged?()
                }
            }
            
            self.assignees = currentIssue.assignees.compactMap {
                guard let user = issueProvider.users[$0] else { return nil }
                return UserViewModel(user: user)
            }

            self.didFetch?()
        }
    }
    
    func addComment(content: String) {
        issueProvider?.addComment(issueNumber: self.issueNumber, content: content) { [weak self] (comment) in
            guard let comment = comment else { return }
            self?.comments.append(CommentViewModel(comment: comment))
            self?.didFetch?()
        }
    }
    
    func editIssue(title: String, description: String) {
        issueProvider?.editIssue(id: issueNumber, title: title, description: description, completion: { [weak self] (editedIssue) in
            guard let `self` = self,
                let editedIssue = editedIssue,
                let author = self.issueProvider?.users[editedIssue.author]
                else { return }
            
            self.title = editedIssue.title
            
            if let editedDescription = editedIssue.description {
                let comment = CommentViewModel(comment: Comment(content: editedDescription, user: author))
                if self.description != nil {
                    self.comments[0] = comment
                } else {
                    self.comments.insert(comment, at: 0)
                }
                self.description = editedDescription
            } else if self.description != nil {
                self.description = nil
                self.comments.remove(at: 0)
            }
            
            self.didFetch?()
        })
    }
    
    func toggleIssueState() {
        issueProvider?.changeIssueState(id: issueNumber, open: !isOpened, completion: { [weak self] issue in
            guard let issue = issue else { return }
            self?.isOpened = issue.isOpened
            self?.didFetch?()
        })
    }
    
    func detailSelectionItemDataSource(of type: DetailSelectionType) -> [[CellComponentViewModel]] {
        var viewModels: [[CellComponentViewModel]] = [[], []]
        switch type {
        case .assignee, .writer:
            let assigneeTable = assignees.reduce(into: Set<Int>()) { $0.insert($1.id) }
            issueProvider?.users.forEach {
                let viewModel = CellComponentViewModel(user: $0.value)
                viewModels[assigneeTable.contains(viewModel.id) ? 0 : 1].append(viewModel)
            }
        case .label:
            let labelTable = labels.reduce(into: Set<Int>()) { $0.insert($1.id) }
            
            labelProvier?.labels.forEach {
                let viewModel = CellComponentViewModel(label: $0.value)
                viewModels[ labelTable.contains(viewModel.id) ? 0 : 1 ].append(viewModel)
            }
        case .milestone:
            milestoneProvider?.milestons.forEach {
                let viewModel = CellComponentViewModel(milestone: $0.value)
                viewModels[milestone?.id == viewModel.id ? 0 : 1].append(viewModel)
            }
        }
        return viewModels
    }
    
    func detailItemSelected(type: DetailSelectionType, selectedItems: [CellComponentViewModel]) {
        var prevSet = Set<Int>()
        let incomingSet = selectedItems.reduce(into: Set<Int>()) { $0.insert($1.id) }
        switch type {
        case .assignee, .writer:
            prevSet = assignees.reduce(into: Set<Int>()) { $0.insert($1.id) }
        case .label:
            prevSet = labels.reduce(into: Set<Int>()) { $0.insert($1.id) }
        case .milestone:
            if let id = milestone?.id {
                prevSet.insert(id)
            }
        }
        
        let idForRemove = prevSet.subtracting(incomingSet)
        let idForAdd = incomingSet.subtracting(prevSet)
        let dispatchGroup = DispatchGroup()
        switch type {
        case .assignee, .writer:
            idForRemove.forEach {
                removeAssignee(of: $0, group: dispatchGroup)
            }
            idForAdd.forEach {
                addAssignee(of: $0, group: dispatchGroup)
            }
        case .label:
            idForRemove.forEach {
                removeLabel(of: $0, group: dispatchGroup)
            }
            idForAdd.forEach {
                addLabel(of: $0, group: dispatchGroup)
            }
        case .milestone:
            if idForAdd.isEmpty && !idForRemove.isEmpty {
                removeMilestone(group: dispatchGroup)
            }
            idForAdd.forEach {
                addMilestone(of: $0, group: dispatchGroup)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.didLabelChanged?()
            self.didMilestoneChanged?()
        }
    }
    
    private func addLabel(of id: Int, group: DispatchGroup?) {
        guard let provider = issueProvider else { return }
        group?.enter()
        provider.addLabel(at: issueNumber, of: id, completion: { [weak self] issue in
            guard issue !=  nil,
                let label = self?.labelProvier?.labels[id]
                else { return }
            self?.labels.append(LabelItemViewModel(label: label))
            group?.leave()
        })
    }
    
    private func removeLabel(of id: Int, group: DispatchGroup?) {
        guard let provider = issueProvider else { return }
        group?.enter()
        provider.deleteLabel(at: issueNumber, of: id, completion: { [weak self] issue in
            if issue == nil { return }
            self?.labels.removeAll(where: {$0.id == id})
            group?.leave()
        })
    }
    
    private func addMilestone(of id: Int, group: DispatchGroup?) {
        guard let provider = issueProvider else { return }
        group?.enter()
        provider.addMilestone(at: issueNumber, of: id, completion: { [weak self] issue in
            guard issue !=  nil,
                let milestone = self?.milestoneProvider?.milestons[id]
                else { return }
            self?.milestone = MilestoneItemViewModel(milestone: milestone, from: .fromServer)
            group?.leave()
        })
    }
    
    private func removeMilestone(group: DispatchGroup?) {
        guard let provider = issueProvider else { return }
        group?.enter()
        provider.deleteMilestone(at: issueNumber, completion: { [weak self] issue in
            guard issue != nil else { return }
            self?.milestone = nil
            group?.leave()
        })
    }
    
    private func addAssignee(of id: Int, group: DispatchGroup?) {
        guard let provider = issueProvider else { return }
        group?.enter()
        provider.addAsignee(at: issueNumber, userId: id, completion: { [weak self] issue in
            guard issue !=  nil,
                let assignee = self?.issueProvider?.users[id] else { return }
            self?.assignees.append(UserViewModel(user: assignee))
            group?.leave()
        })
    }
    
    private func removeAssignee(of id: Int, group: DispatchGroup?) {
        guard let provider = issueProvider else { return }
        group?.enter()
        provider.deleteLabel(at: issueNumber, of: id, completion: { [weak self] issue in
            guard issue !=  nil else { return }
            self?.assignees.removeAll(where: {$0.id == id})
            group?.leave()
        })
    }
}
