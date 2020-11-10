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
    @IBOutlet weak var floatingButton: UIButton!

    lazy var floatingButtonAspectRatioConstraint: NSLayoutConstraint = {
        self.floatingButton.widthAnchor.constraint(equalTo: self.floatingButton.heightAnchor)
    }()
    
    private var viewingMode: ViewingMode = .general
    
    var issueListViewModel: IssueListViewModelProtocol? {
        didSet {
            issueListViewModel?.didFetch = { [weak self] in
                self?.collectionView.reloadData()
            }
            issueListViewModel?.invalidateLayout = { [weak self] in
                self?.collectionView.collectionViewLayout.invalidateLayout()
            }
            issueListViewModel?.didCellChecked = { [weak self] (indexPath, check) in
                guard let cell = self?.collectionView.cellForItem(at: indexPath) as? IssueCellView else { return }
                cell.setCheck(check)
            }
            issueListViewModel?.showTitleWithCheckNum = { [weak self] (num) in
                guard let vieingMode = self?.viewingMode, vieingMode == .edit else { return }
                self?.title = "\(num) 개 선택"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
        issueListViewModel?.needFetchItems()
        floatingButtonAspectRatioConstraint.isActive = true
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .automatic
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView else { return }
            cell.resetScrollOffset()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.layer.cornerRadius = floatingButton.bounds.height / 2 * 1
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
            issueListViewModel?.selectCell(at: indexPath)
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
            issueListViewModel?.selectAllCells()
        }
    }
    
    @IBAction func floatingButtonTapped(_ sender: Any) {
        switch viewingMode {
        case .edit:
            break
        case .general:
            AddNewIssueViewController.present(at: self, addType: .newIssue, onDismiss: nil)
        }
    }
    
    private func toEditMode() {
        viewingMode = .edit
        title = "0 개 선택"
        rightNavButton.title = "Cancel"
        leftNavButton.title = "Select All"
        changeButtonTo(mode: .edit)
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView else { return }
            cell.showCheckBox(show: true, animation: true)
        }
    }
    
    private func toGeneralMode() {
        viewingMode = .general
        title = "이슈"
        rightNavButton.title = "Edit"
        leftNavButton.title = "Filter"
        changeButtonTo(mode: .general)
        issueListViewModel?.clearSelectedCells()
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView else { return }
            cell.showCheckBox(show: false, animation: true)
        }
    }
    
    private func changeButtonTo(mode: ViewingMode) {
        switch mode {
        case .edit:
            floatingButtonAspectRatioConstraint.isActive = false
            floatingButton.setTitle("선택 이슈 닫기", for: .normal)
            floatingButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
            floatingButton.backgroundColor = .red
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.floatingButton.contentEdgeInsets.left = 10
                self.floatingButton.contentEdgeInsets.right = 10
                self.floatingButton.imageEdgeInsets.left = -5
            }
        case .general:
            floatingButtonAspectRatioConstraint.isActive = true
            floatingButton.setTitle("", for: .normal)
            floatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
            floatingButton.backgroundColor = UIColor(displayP3Red: 72/255, green: 133/255, blue: 195/255, alpha: 1)
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.floatingButton.contentEdgeInsets.right = 0
                self.floatingButton.contentEdgeInsets.left = 0
                self.floatingButton.imageEdgeInsets.left = 0
            }
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
    
}

// MARK: - UICollectionViewDataSource Implementation

extension IssueListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellView: IssueCellView = collectionView.dequeueCell(at: indexPath),
            let cellViewModel = issueListViewModel?.cellForItemAt(path: indexPath) else { return UICollectionViewCell() }
        cellView.configure(issueItemViewModel: cellViewModel)
        cellView.delegate = self
        cellView.showCheckBox(show: viewingMode == .edit, animation: false)
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueListViewModel?.numberOfItem() ?? 0
    }
}

// MARK: - IssucCellViewDelegate Implementation

extension IssueListViewController: IssucCellViewDelegate {
    
    func closeIssueButtonTapped(_ issueCellView: IssueCellView, at id: Int) {
        
    }
    
    func deleteIssueButtonTapped(_ issueCellView: IssueCellView, at id: Int) {
        
    }
    
    func issueCellViewBeginDragging(_ issueCellView: IssueCellView, at id: Int) {
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView, cell != issueCellView else { return }
            UIView.animate(withDuration: 0.5) {
                cell.cellHorizontalScrollView.contentOffset = CGPoint.zero
            }
        }
    }
    
}
