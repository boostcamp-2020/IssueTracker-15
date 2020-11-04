//
//  DetailConditionFilterViewController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class DetailConditionSelectViewController: UIViewController {
    
    @IBOutlet weak var titleNavItem: UINavigationItem!
    
    // TODO: Dependency Injection for ContentMode
    private var contentMode: ComponentStyle
    private var maximumNumSelected: Int
    var onSelectionComplete: (([ConditionCellViewModel]) -> Void)?
    
    // TODO: Dummy Data to ViewModelProtocol
    private var viewModelDataSource: [[ConditionCellViewModel]] = [ [],
                                                                    [
                                                                        ConditionCellViewModel(title: "마일스톤 1", element: "2020-10-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마 2", element: "2020-11-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일일일스톤 3", element: "2020-12-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일아아아kkk스톤 4", element: "2020-09-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 5", element: "2020-08-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 6", element: "2019-01-30 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 7", element: "2018-02-21 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 8", element: "2020-03-06 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 1", element: "2021-12-22 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 1", element: "2017-06-03 00:00:00")
        ]
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    init(nibName: String,
         bundle: Bundle?,
         contentMode: ComponentStyle, maximuSelected: Int) {
        self.contentMode = contentMode
        self.maximumNumSelected = maximuSelected
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        self.contentMode = .userInfo
        viewModelDataSource = [[], []]
        self.maximumNumSelected = 1
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        titleNavItem.title = title
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(type: DetailConditionSelectCellView.self)
    }
    
}

// MARK: - Actions

extension DetailConditionSelectViewController {
    
    @IBAction func cancleButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // TODO: 선택된 항목 delegate or closure를 통해 반환
        dismiss(animated: true, completion: nil)
        onSelectionComplete?(viewModelDataSource[0])
    }
    
}

// MARK: - UITableViewDelegate Implementation

extension DetailConditionSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathFrom = indexPath
        let indexPathTo: IndexPath
        let cell = tableView.cellForRow(at: indexPath) as? DetailConditionSelectCellView
        
        let source = indexPath.section
        let dest = source == 0 ? 1 : 0
        indexPathTo = IndexPath(row: viewModelDataSource[dest].count, section: dest)
        
        let data = viewModelDataSource[source].remove(at: indexPath.row)
        viewModelDataSource[dest].append(data)
        tableView.moveRow(at: indexPathFrom, to: indexPathTo)
        cell?.setCheck(dest == 0)
        
        if viewModelDataSource[0].count > maximumNumSelected {
            let indexPathFrom = IndexPath(row: 0, section: 0)
            let indexPathTo = IndexPath(row: viewModelDataSource[1].count, section: 1)
            let cell = tableView.cellForRow(at: indexPathFrom) as? DetailConditionSelectCellView
            
            let data = viewModelDataSource[0].remove(at: 0)
            viewModelDataSource[1].append(data)
            tableView.moveRow(at: indexPathFrom, to: indexPathTo)
            cell?.setCheck(false)
        }
    }
    
}

// MARK: - UITableViewDataSource Implementation

extension DetailConditionSelectViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Choosen (max: \(maximumNumSelected))" : "Unchoosen"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelDataSource[safe: section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModelDataSource[safe: indexPath.section]?[safe: indexPath.row],
            let cell: DetailConditionSelectCellView = tableView.dequeueCell(at: indexPath)
        else { return UITableViewCell() }
        cell.configure(type: contentMode, viewModel: cellViewModel)
        cell.setCheck(indexPath.section == 0)
        return cell
    }
    
}

// MARK: - Load From Nib

extension DetailConditionSelectViewController {
    
    static let nibName = "DetailFilterViewController"
    
    // TODO: Dependency Injection ( ViewModels )
    static func createViewController(contentMode: ComponentStyle, title: String, maximumSelected: Int) -> DetailConditionSelectViewController {
        let vc = DetailConditionSelectViewController(nibName: nibName,
                                                     bundle: Bundle.main,
                                                     contentMode: contentMode,
                                                     maximuSelected: maximumSelected)
        vc.title = title
        return vc
    }
    
}
