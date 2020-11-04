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
    
    weak var filterViewModel: IssueFilterViewModelProtocol?
    var selected = [Bool](repeating: false, count: 5)
    
    init?(coder: NSCoder, filterViewModel: IssueFilterViewModelProtocol) {
        self.filterViewModel = filterViewModel
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
    
    private func willDisplayConditionCell(at type: Condition, cell: UITableViewCell) {
        guard let filterViewModel = filterViewModel else { return }
        cell.accessoryType = filterViewModel.condition(of: type) ? .checkmark : .none
    }
    
    private func willDisplayDetailConditionCell(at type: DetailCondition, cell: DetailFilterCellView) {
        guard let filterViewModel = filterViewModel,
              let cellViewModel = filterViewModel.detailCondition(of: type)
        else { return }

        let style: ComponentStyle
        switch type {
        case .assignee, .writer:
            style = .userInfo
        case .label:
            style = .label
        case .milestone:
            style = .milestone
        }
        cell.configure(style: style, viewModel: cellViewModel)
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
    
    private func conditionSelected(at type: Condition, cell: UITableViewCell) {
        guard let filterViewModel = filterViewModel else { return }
        filterViewModel.generalConditionSelected(at: type)
        cell.accessoryType = filterViewModel.condition(of: type) ? .checkmark : .none
    }
    
    private func detailConditionSelected(at type: DetailCondition, cell: UITableViewCell) {
        guard let cell = cell as? DetailFilterCellView,
              let dataSource = filterViewModel?.detailConditionDataSource(of: type) else { return }
        
        // TODO: detail Condition Select ViewController 에서 사용할 모델 생각해보기
        let componentStyle: ComponentStyle
        let title: String
        switch type {
        case .assignee:
            componentStyle = .userInfo
            title = "담당자"
        case .label:
            componentStyle = .label
            title = "레이블"
        case .milestone:
            componentStyle = .milestone
            title = "마일스톤"
        case .writer:
            componentStyle = .userInfo
            title = "작성자"
        }
        
        let vc = DetailConditionSelectViewController.createViewController(contentMode: componentStyle,
                                                                          title: title,
                                                                          dataSource: dataSource,
                                                                          maximumSelected: 1)
        
        vc.onSelectionComplete = { selected in
            self.filterViewModel?.detailConditionSelected(at: type, id: selected[safe: 0]?.id)
            cell.configure(style: componentStyle, viewModel: selected[safe: 0])
        }
        present(vc, animated: true)
    }
}
