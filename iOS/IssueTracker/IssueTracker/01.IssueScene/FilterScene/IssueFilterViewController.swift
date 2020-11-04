//
//  IssueFilterViewController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueFilterViewController: UITableViewController {
    
    enum FilterSection: Int {
        case condition = 0
        case detailCondition = 1
    }
    
    // TODO: Condition/ DetailCondition To Filter Model Data
    enum Condition: Int {
        case issueOpened = 0
        case issueFromMe = 1
        case issueAssignedToMe = 2
        case issueCommentedByMe = 3
        case issueClosed = 4
    }
    
    enum DetailCondition: Int {
        case writer = 0
        case label = 1
        case milestone = 2
        case assignee = 3
    }
    
    var selected = [Bool](repeating: false, count: 5)
    
    // TODO: Dependency  FilterStatus, (IssueService, MilestoneService, LabelService, CommentService) for DetailCondition
    // 이후에 적절한 Dependency를 받을 것! ( ex: milestoneProvider, labelProvider, userInfoProvider ...)
    private weak var milestoneListViewModel: MilestoneListViewModelProtocol?
    private weak var labelListViewModel: LabelListViewModelProtocol?
    init?(coder: NSCoder, milestoneListViewModel: MilestoneListViewModelProtocol, labelListViewModel: LabelListViewModelProtocol) {
        self.milestoneListViewModel = milestoneListViewModel
        self.labelListViewModel = labelListViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "필터 선택"
        configure()
    }
    
    private func configure() {
        tableView.sectionFooterHeight = 0
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .gray
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureConditionCells() {
        (0..<5).forEach {
            guard let cell = self.tableView.cellForRow(at: IndexPath(row: $0, section: 0)) else { return }
            cell.accessoryType = selected[$0] ? .checkmark : .none
        }
    }
    
}

// MARK: - Action

extension IssueFilterViewController {
    
    @IBAction func cancleButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // TODO: delegate or closure를 통해 filter 내용 전달
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - TableView Implementation

extension IssueFilterViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath),
            let sectionType = FilterSection(rawValue: indexPath.section)
            else { return }
        
        switch  sectionType {
        case .condition:
            let isSelected = selected[indexPath.row]
            selected[indexPath.row] = !isSelected
            cell.accessoryType = selected[indexPath.row] ? .checkmark : .none
        case .detailCondition:
            guard let detailMode = DetailCondition(rawValue: indexPath.row) else { return }
            let vc: DetailFilterViewController
            switch detailMode {
            case .assignee:
                vc = DetailFilterViewController.createViewController(contentMode: .userInfo, title: "담당자", maximumSelected: 1)
            case .label:
                vc = DetailFilterViewController.createViewController(contentMode: .label, title: "레이블", maximumSelected: 1)
            case .milestone:
                vc = DetailFilterViewController.createViewController(contentMode: .milestone, title: "마일스톤", maximumSelected: 1)
            case .writer:
                vc = DetailFilterViewController.createViewController(contentMode: .userInfo, title: "작성자", maximumSelected: 1)
            }
            present(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
