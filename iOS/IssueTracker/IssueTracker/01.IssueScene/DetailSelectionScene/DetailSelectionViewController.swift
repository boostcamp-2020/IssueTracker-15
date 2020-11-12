//
//  DetailConditionFilterViewController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class DetailSelectionViewController: UIViewController {
    
    @IBOutlet weak var titleNavItem: UINavigationItem!

    var onSelectionComplete: (([CellComponentViewModel]) -> Void)?
    
    private var viewModel: DetailSelectionViewModelProtocol
    
    @IBOutlet weak var tableView: UITableView!
    
    init(nibName: String, bundle: Bundle?, viewModel: DetailSelectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel.didChanged = { (from, to) in
            guard let cell = self.tableView.cellForRow(at: from) as? DetailConditionSelectCellView else { return }
            self.tableView.moveRow(at: from, to: to)
            cell.setCheck(to.section == 0)
        }
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = DetailSelectionViewModel(detailCondition: .writer, viewModelDataSource: [[], []], maxSelection: 0)
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

extension DetailSelectionViewController {
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        onSelectionComplete?(viewModel.result)
    }
    
}

// MARK: - UITableViewDelegate Implementation

extension DetailSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(at: indexPath)
    }
    
}

// MARK: - UITableViewDataSource Implementation

extension DetailSelectionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "chosen" : "unchosen"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDatas(at: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DetailConditionSelectCellView = tableView.dequeueCell(at: indexPath)
        else { return UITableViewCell() }
        cell.configure(type: viewModel.selectionType.cellStyle, viewModel: viewModel.cellForRow(at: indexPath))
        cell.setCheck(indexPath.section == 0)
        return cell
    }
    
}

// MARK: - Load From Nib

extension DetailSelectionViewController {
    
    static let nibName = "DetailSelectionViewController"
    
    static func createViewController(with viewModel: DetailSelectionViewModelProtocol) -> DetailSelectionViewController {
        let vc = DetailSelectionViewController(nibName: nibName, bundle: Bundle.main, viewModel: viewModel)
        return vc
    }
    
}
