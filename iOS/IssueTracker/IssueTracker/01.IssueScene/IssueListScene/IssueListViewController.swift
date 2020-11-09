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

    lazy var addIssueButtonAspectRatioConstraint: NSLayoutConstraint = {
        self.addIssueButton.widthAnchor.constraint(equalTo: self.addIssueButton.heightAnchor)
    }()
    
    private var viewingMode: ViewingMode = .general
    var issueListViewModel: IssueListViewModel? {
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
        addIssueButtonAspectRatioConstraint.isActive = true
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
        addIssueButton.layer.cornerRadius = addIssueButton.bounds.height / 2 * 1
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
    
    @IBAction func addIssueButtonTapped(_ sender: Any) {
        // TODO : add issue
        AddNewIssueViewController.present(at: self, addType: .newIssue, onDismiss: nil)
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
    
    @IBAction func closeAllSelectedIssueButtonTapped(_ sender: Any) {
        
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
            addIssueButtonAspectRatioConstraint.isActive = false
            addIssueButton.setTitle("선택 이슈 닫기", for: .normal)
            addIssueButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
            addIssueButton.backgroundColor = .red
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.addIssueButton.contentEdgeInsets.left = 10
                self.addIssueButton.contentEdgeInsets.right = 10
                self.addIssueButton.imageEdgeInsets.left = -5
            }
        case .general:
            addIssueButtonAspectRatioConstraint.isActive = true
            addIssueButton.setTitle("", for: .normal)
            addIssueButton.setImage(UIImage(systemName: "plus"), for: .normal)
            addIssueButton.backgroundColor = UIColor(displayP3Red: 72/255, green: 133/255, blue: 195/255, alpha: 1)
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.addIssueButton.contentEdgeInsets.right = 0
                self.addIssueButton.contentEdgeInsets.left = 0
                self.addIssueButton.imageEdgeInsets.left = 0
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
        cellView.showCheckBox(show: viewingMode == .edit, animation: false)
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueListViewModel?.numberOfItem() ?? 0
    }
}
