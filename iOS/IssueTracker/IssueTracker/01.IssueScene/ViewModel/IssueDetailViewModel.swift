//
//  IssueDetailViewModel.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

protocol IssueDetailViewModelProtocol: AnyObject {
    var issueNumber: Int { get }
    var title: String { get }
    var author: UserViewModel { get }
    var isOpened: Bool { get }
    var didFetch: (() -> Void)? { get set }
    var milestone: MilestoneItemViewModel? { get }
    var comments: [CommentViewModel] { get }
    var labels: [LabelItemViewModel] { get }
    var assignees: [UserViewModel] { get }
    func needFetchDetails()
    func addComment(content: String)
    
    var didLabelChanged: (() -> Void)? { get set }
    var didMilestoneChanged: (() -> Void)? { get set }
    
    func detailSelectionItemDataSource(of type: DetailSelectionType) -> [[CellComponentViewModel]]
    func detailItemSelected(type: DetailSelectionType, selectedItems: [CellComponentViewModel])
}

struct CommentViewModel {
    let content: String
    let createAt: String
    let userName: String
    let imageURL: String?
    
    init(comment: Comment) {
        content = comment.content
        createAt = comment.createAt
        userName = comment.author.name
        imageURL = comment.author.imageUrl
    }
}

protocol UserViewModelProtocol {
    var userName: String { get set }
    var imageURL: String? { get set }
}

struct UserViewModel {
    var userName: String
    var imageURL: String?
    
    init(user: User) {
        userName = user.name
        imageURL = user.imageUrl
    }
    
    init(userName: String, imageURL: String? = nil) {
        self.userName = userName
        self.imageURL = imageURL
    }
}

class IssueDetailViewModel: IssueDetailViewModelProtocol {
    
    var issueNumber: Int = 0
    var title: String = ""
    var author: UserViewModel = UserViewModel(userName: "")
    var didFetch: (() -> Void)?
    var isOpened: Bool = false
    var milestone: MilestoneItemViewModel?
    var comments: [CommentViewModel] = [CommentViewModel]()
    var labels: [LabelItemViewModel] = [LabelItemViewModel]()
    var assignees: [UserViewModel] = [UserViewModel]()
    
    var didLabelChanged: (() -> Void)?
    var didMilestoneChanged: (() -> Void)?
    
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
                let currentIssue = issue
                else { return }
            
            self.issueNumber = currentIssue.id
            self.title = currentIssue.title
            self.isOpened = currentIssue.isOpened
            self.author = UserViewModel(user: currentIssue.author)
            
            self.comments = currentIssue.comments.map { CommentViewModel(comment: $0) }
            
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
            
            self.assignees = currentIssue.assignees.map { UserViewModel(user: $0)}
            
            self.didFetch?()
        }
    }
    
    func addComment(content: String) {
        issueProvider?.addComment(issueNumber: self.issueNumber, content: content) { [weak self] (response) in
            guard let `self` = self, response else { return }
            self.comments.append(CommentViewModel(comment: Comment(content: content, user: User(id: 1))))
            self.didFetch?()
        }
    }
    
    private var mockUserInfo = [
        CellComponentViewModel(title: "SHIVVVPP", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "유시형", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "namda-on", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "moaikang", element: "2020-08-11T00:00:00.000Z"),
        CellComponentViewModel(title: "maong0927", element: "2020-08-11T00:00:00.000Z")
    ]
    func detailSelectionItemDataSource(of type: DetailSelectionType) -> [[CellComponentViewModel]] {
        var viewModels: [[CellComponentViewModel]] = [[], []]
        switch type {
        case .assignee, .writer:
            // TODO: UserInfoProvider 구현
            viewModels = [ [], mockUserInfo  ]
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
            return
        case .label:
            prevSet = labels.reduce(into: Set<Int>()) { $0.insert($1.id) }
        case .milestone:
            if let id = milestone?.id {
                prevSet.insert(id)
            }
        }
        
        let idForRemove = prevSet.subtracting(incomingSet)
        let idForAdd = incomingSet.subtracting(prevSet)
        
        switch type {
        case .assignee, .writer:
            return
        case .label:
            idForRemove.forEach { deleteLabel(of: $0)}
            idForAdd.forEach { addLabel(of: $0)  }
        case .milestone:
            if idForAdd.isEmpty && !idForRemove.isEmpty { removeMilestone() }
            idForAdd.forEach { addMilestone(of: $0) }
        }
    }
    
    private func addLabel(of id: Int) {
        self.issueProvider?.addLabel(at: issueNumber, of: id, completion: { [weak self] issue in
            guard issue !=  nil,
                let label = self?.labelProvier?.labels[id]
                else { return }
            self?.labels.append(LabelItemViewModel(label: label))
            self?.didLabelChanged?()
        })
    }
    
    private func deleteLabel(of id: Int) {
        self.issueProvider?.deleteLabel(at: issueNumber, of: id, completion: { [weak self] issue in
            if issue == nil { return }
            self?.labels.removeAll(where: {$0.id == id})
            self?.didLabelChanged?()
        })
    }
    
    private func addMilestone(of id: Int) {
        self.issueProvider?.addMilestone(at: issueNumber, of: id, completion: { [weak self] issue in
            guard issue !=  nil,
                let milestone = self?.milestoneProvider?.milestons[id]
                else { return }
            self?.milestone = MilestoneItemViewModel(milestone: milestone, from: .fromServer)
            self?.didMilestoneChanged?()
        })
    }
    
    private func removeMilestone() {
        self.issueProvider?.deleteMilestone(at: issueNumber, completion: { [weak self] issue in
            guard issue != nil else { return }
            self?.milestone = nil
            self?.didMilestoneChanged?()
        })
    }
}
