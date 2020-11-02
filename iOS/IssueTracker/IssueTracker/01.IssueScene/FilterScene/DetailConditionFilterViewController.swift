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
    
    
    // TODO: Dependency Injection for ContentMode
    private var contentMode: ContentMode? = .label//nil
    
    // TODO: Dummy Data to ViewModelProtocol
    private var choosenDatas: [String] = [
        "feature"
    ]
    
    private var unchoosenDatas: [String] = [
        "model", "ABCDE", "Inhencement", "SHIVVVPP", "GORILA", "GIRIN", "KIMSHINWOO"
    ]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView() {
        guard let contentMode = contentMode else { return }
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
    
}

// MARK: - UITableViewDataSource Implementation
extension DetailConditionFilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "selected" : ""
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.bounds.height / 14
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? choosenDatas.count : unchoosenDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentMode = contentMode else { return UITableViewCell() }
        let selected = indexPath.section == 0
        switch contentMode {
        case .userInfo:
            guard let cell: UserConditionCellView = tableView.dequeueCell(at: indexPath) else { return UITableViewCell() }
            cell.isChoosen = selected
            cell.configure()
            return cell
        case .milestone:
            guard let cell: MilestoneConditionCellView = tableView.dequeueCell(at: indexPath) else { return UITableViewCell() }
            cell.isChoosen = selected
            cell.configure()
            return cell
        case .label:
            guard let cell: LabelConditionCellView = tableView.dequeueCell(at: indexPath) else { return UITableViewCell() }
            cell.isChoosen = selected
            cell.configure()
            return cell
        }
    }
    
}

// MARK: - LoadFromNib
extension DetailConditionFilterViewController {
    
    static let nibName = "DetailConditionFilterViewController"
    
    // TODO: Dependency Injection ( ViewModels )
    static func createViewController(contentMode: ContentMode) -> DetailConditionFilterViewController {
        let vc = DetailConditionFilterViewController(nibName: nibName, bundle: Bundle.main)
        vc.contentMode = contentMode
        return vc
    }
    
}
