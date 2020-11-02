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
            let vc: DetailConditionFilterViewController
            switch detailMode {
            case .assignee:
                vc = DetailConditionFilterViewController.createViewController(contentMode: .userInfo)
            case .label:
                vc = DetailConditionFilterViewController.createViewController(contentMode: .label)
            case .milestone:
                vc = DetailConditionFilterViewController.createViewController(contentMode: .milestone)
            case .writer:
                vc = DetailConditionFilterViewController.createViewController(contentMode: .userInfo)
            }
            present(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
