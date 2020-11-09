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
    
    var onSelectionComplete: (([Bool], [Int]) -> Void)?
    var filterViewModel: IssueFilterViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

// MARK: - Action

extension IssueFilterViewController {
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        guard let filterViewModel = filterViewModel else { return }
        onSelectionComplete?(filterViewModel.generalConditions, filterViewModel.detailConditions)
    }
    
}

// MARK: - TableView Implementation

extension IssueFilterViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let sectionType = FilterSection(rawValue: indexPath.section) else { return }
        switch sectionType {
        case .condition:
            guard let type = Condition(rawValue: indexPath.row) else { return }
            willDisplayConditionCell(at: type, cell: cell)
        case .detailCondition:
            guard let type = DetailCondition(rawValue: indexPath.row),
                let cell = cell as? DetailFilterCellView
                else { return }
            willDisplayDetailConditionCell(at: type, cell: cell)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath),
            let sectionType = FilterSection(rawValue: indexPath.section)
            else { return }
        
        switch  sectionType {
        case .condition:
            guard let condition = Condition(rawValue: indexPath.row) else { return }
            conditionSelected(at: condition, cell: cell)
        case .detailCondition:
            guard let detailCondition = DetailCondition(rawValue: indexPath.row) else { return }
            detailConditionSelected(at: detailCondition, cell: cell)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - TableView Private Functions

extension IssueFilterViewController {
    
    private func willDisplayConditionCell(at type: Condition, cell: UITableViewCell) {
        guard let filterViewModel = filterViewModel else { return }
        cell.accessoryType = filterViewModel.condition(of: type) ? .checkmark : .none
    }
    
    private func willDisplayDetailConditionCell(at type: DetailCondition, cell: DetailFilterCellView) {
        guard let filterViewModel = filterViewModel,
            let cellViewModel = filterViewModel.detailCondition(of: type)
            else { return }
        cell.configure(style: type.cellStyle, viewModel: cellViewModel)
    }
    
    private func conditionSelected(at type: Condition, cell: UITableViewCell) {
        guard let filterViewModel = filterViewModel else { return }
        filterViewModel.generalConditionSelected(at: type)
        cell.accessoryType = filterViewModel.condition(of: type) ? .checkmark : .none
    }
    
    private func detailConditionSelected(at type: DetailCondition, cell: UITableViewCell) {
        guard let filterViewModel = filterViewModel,
            let cell = cell as? DetailFilterCellView
            else { return }
        
        let dataSource = filterViewModel.detailConditionDataSource(of: type)
        let viewModel = DetailConditionViewModel(detailCondition: type, viewModelDataSource: dataSource, maxSelection: 1)
        let vc = DetailConditionSelectViewController.createViewController(with: viewModel)
        
        vc.onSelectionComplete = { selected in
            self.filterViewModel?.detailConditionSelected(at: type, id: selected[safe: 0]?.id)
            cell.configure(style: type.cellStyle, viewModel: selected[safe: 0])
        }
        present(vc, animated: true)
    }
    
}

// MARK: - Load From StoryBoard

extension IssueFilterViewController {
    static let storyBoardName = "IssueFilter"
    
    static func present(at viewController: UIViewController,
                        filterViewModel: IssueFilterViewModelProtocol?,
                        onDismiss: (([Bool], [Int]) -> Void)?) {
        
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        guard let container = storyBoard.instantiateInitialViewController() as? UINavigationController,
            let vc = container.topViewController as? IssueFilterViewController
            else { return }
        
        vc.filterViewModel = filterViewModel
        vc.onSelectionComplete = onDismiss
        viewController.present(container, animated: true, completion: nil)
    }
}
