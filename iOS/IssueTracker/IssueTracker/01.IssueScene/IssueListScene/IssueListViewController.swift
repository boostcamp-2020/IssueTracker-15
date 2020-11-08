//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/01.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueListViewController: UIViewController {
    
    enum ViewingMode {
        case general
        case edit
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rightNavButton: UIBarButtonItem!
    @IBOutlet weak var leftNavButton: UIBarButtonItem!
    @IBOutlet weak var addIssueButton: UIButton!
    @IBOutlet weak var closeSelectedIssueButton: UIBarButtonItem!
    
    private var viewingMode: ViewingMode = .general
    var issueListViewModel: IssueListViewModel? {
        didSet {
            issueListViewModel?.didFetch = { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "이슈"
        configureSearchBar()
        configureCollectionView()
        addIssueButton.layer.cornerRadius = addIssueButton.frame.width/2
        navigationItem.title = "이슈"
        issueListViewModel?.needFetchItems()
        navigationController?.isToolbarHidden = true
    }
    
    // TODO: SerachBar Configure
    private func configureSearchBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.registerCell(type: IssueCellView.self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didSelectCell(_:)))
        self.collectionView.addGestureRecognizer(tap)
        self.collectionView.isUserInteractionEnabled = true
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let cellHeight = self.view.bounds.height / 10
        layout.estimatedItemSize = CGSize(width: self.view.bounds.width, height: cellHeight)
        layout.minimumLineSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
}

// MARK: - Actions

extension IssueListViewController {
    @objc func didSelectCell(_ sender: UITapGestureRecognizer) {
        guard let indexPath =  self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) else { return }
        
        switch viewingMode {
        case .general:
            presentIssueDetailViewController(indexPath: indexPath)
        case .edit:
            
            break
        }
    }
    
    @IBAction func rightNavButtonTapped(_ sender: Any) {
        switch viewingMode {
        case .general:
            toEditMode()
        case .edit:
            toGeneralMode()
        }
    }
    
    @IBAction func leftNavButtonTapped(_ sender: Any) {
        switch viewingMode {
        case .general:
            presentFilterViewController()
        case .edit:
            // TODO: SelectAll
            break
        }
    }
    
    @IBAction func closeAllSelectedIssueButtonTapped(_ sender: Any) {
        
    }
    
    private func toEditMode() {
        viewingMode = .edit
        rightNavButton.title = "Cancel"
        leftNavButton.title = "Select All"
        navigationController?.isToolbarHidden = false
        tabBarController?.tabBar.isHidden = true
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView else { return }
            cell.showCheckBox(show: true, animation: true)
        }
    }
    
    private func toGeneralMode() {
        viewingMode = .general
        rightNavButton.title = "Edit"
        leftNavButton.title = "Filter"
        navigationController?.isToolbarHidden = true
        tabBarController?.tabBar.isHidden = false
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView else { return }
            cell.showCheckBox(show: false, animation: true)
        }
    }
}

// MARK: - Present

extension IssueListViewController {
    
    private func presentFilterViewController() {
        guard viewingMode == .general,
            let issueListViewModel  = issueListViewModel
            else { return }
        let onDismiss = { (generalCondition: [Bool], detailCondition: [Int]) in
            issueListViewModel.filter = IssueFilter(generalCondition: generalCondition, detailCondition: detailCondition)
        }
        IssueFilterViewController.present(at: self, filterViewModel: issueListViewModel.createFilterViewModel(), onDismiss: onDismiss)
    }
    
    private func presentIssueDetailViewController(indexPath: IndexPath) {
        guard let issueListViewModel = issueListViewModel,
            let issueDetailViewModel = issueListViewModel.createIssueDetailViewModel(path: indexPath)
            else { return }
        
        let issueDetailVC = IssueDetailViewController.createViewController(issueDetailViewModel: issueDetailViewModel)
        
        self.navigationController?.pushViewController(issueDetailVC, animated: true)
    }
    
    @IBSegueAction func addIssueSeguePerformed(_ coder: NSCoder) -> AddNewIssueViewController? {
        let addIssueViewController = AddNewIssueViewController(coder: coder)
        // addIssueVC의 doneButtonTapped 주입
        return addIssueViewController
    }
    
}

// MARK: - UICollectionViewDataSource Implementation

extension IssueListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellView: IssueCellView = collectionView.dequeueCell(at: indexPath),
              let cellViewModel = issueListViewModel?.cellForItemAt(path: indexPath) else { return UICollectionViewCell() }
        cellView.configure(issueItemViewModel: cellViewModel)
        cellView.showCheckBox(show: viewingMode == .edit, animation: false)
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueListViewModel?.numberOfItem() ?? 0
    }
}
