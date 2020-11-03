//
//  DetailConditionFilterViewController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class DetailConditionFilterViewController: UIViewController {
    
    enum ContentMode {
        case userInfo
        case milestone
        case label
    }
    
    @IBOutlet weak var titleNavItem: UINavigationItem!
    
    // TODO: Dependency Injection for ContentMode
    private var contentMode: ContentMode//nil
    
    
    // TODO: Dummy Data to ViewModelProtocol
    //    private var viewModelDataSource: [[ConditionCellViewModel]] = [ [],
    //        [
    //        ConditionCellViewModel(title: "타이틀1", element: "#123456"),
    //        ConditionCellViewModel(title: "타이틀2", element: "#123456"),
    //        ConditionCellViewModel(title: "타이틀3", element: "#345677"),
    //        ConditionCellViewModel(title: "타이틀4", element: "#ABCDEF"),
    //        ConditionCellViewModel(title: "타이틀5", element: "#ABDDEE"),
    //        ConditionCellViewModel(title: "타이틀5", element: "#ABDDFF")
    //        ]
    //    ]
    private var viewModelDataSource: [[ConditionCellViewModel]] = [ [],
                                                                    [
                                                                        ConditionCellViewModel(title: "마일스톤 1", element: "2020-10-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 2", element: "2020-11-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 3", element: "2020-12-11 00:00:00"),
                                                                        ConditionCellViewModel(title: "마일스톤 4", element: "2020-09-11 00:00:00"),
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
         contentMode: ContentMode) {
        self.contentMode = contentMode
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        self.contentMode = .userInfo
        viewModelDataSource = [[],[]]
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        titleNavItem.title = title
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView() {
        switch contentMode {
        case .userInfo:
            tableView.register(type: UserConditionCellView.self)
        case .milestone:
            tableView.register(type: MilestoneConditionCellView.self)
        case .label:
            tableView.register(type: LabelConditionCellView.self)
        }
    }
    
}

// MARK: - Actions
extension DetailConditionFilterViewController {
    
    @IBAction func cancleButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate Implementation
extension DetailConditionFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathFrom = indexPath
        let indexPathTo: IndexPath
        let cell: ConditionCellView?
        let choosen: Bool
        
        if indexPath.section == 0 {
            cell = tableView.cellForRow(at: indexPath) as? ConditionCellView
            let data = viewModelDataSource[0].remove(at: indexPath.row)
            viewModelDataSource[1].append(data)
            indexPathTo = IndexPath(row: 0, section: 1)
            choosen = false
        } else {
            cell = tableView.cellForRow(at: indexPath) as? ConditionCellView
            let data = viewModelDataSource[1].remove(at: indexPath.row)
            viewModelDataSource[0].insert(data, at: 0)
            indexPathTo = IndexPath(row: viewModelDataSource[0].count - 1, section: 0)
            choosen = true
        }
        
        tableView.moveRow(at: indexPathFrom, to: indexPathTo)
        cell?.setCheck(choosen)
    }
    
}

// MARK: - UITableViewDataSource Implementation
extension DetailConditionFilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Choosen" : "Unchoosen"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelDataSource[safe: section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModelDataSource[safe: indexPath.section]?[safe: indexPath.row] else { return UITableViewCell() }
        let cell: ConditionCellView?
        switch contentMode {
        case .userInfo:
            cell = tableView.dequeueReusableCell(withIdentifier: UserConditionCellView.cellIdentifier,
                                                 for: indexPath) as? UserConditionCellView
        case .milestone:
            cell = tableView.dequeueReusableCell(withIdentifier: MilestoneConditionCellView.cellIdentifier,
                                                 for: indexPath) as? MilestoneConditionCellView
        case .label:
            cell = tableView.dequeueReusableCell(withIdentifier: LabelConditionCellView.cellIdentifier,
                                                 for: indexPath) as? LabelConditionCellView
        }
        cell?.configure(viewModel: cellViewModel)
        cell?.setCheck(indexPath.section == 0)
        return cell ?? UITableViewCell()
    }
    
}

// MARK: - LoadFromNib
extension DetailConditionFilterViewController {
    
    static let nibName = "DetailConditionFilterViewController"
    
    // TODO: Dependency Injection ( ViewModels )
    static func createViewController(contentMode: ContentMode, title: String) -> DetailConditionFilterViewController {
        let vc = DetailConditionFilterViewController(nibName: nibName,
                                                     bundle: Bundle.main,
                                                     contentMode: contentMode)
        vc.title = title
        return vc
    }
    
}
