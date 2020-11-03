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
    @IBOutlet weak var rightNavButton: UIButton!
    @IBOutlet weak var leftNavButton: UIButton!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    private var viewingMode: ViewingMode = .general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "이슈"
        configureSearchBar()
        configureCollectionView()
    }
    
    // TODO: SerachBar Configure
    private func configureSearchBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.register(type: IssueCellView.self)
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let cellHeight = self.view.bounds.height / 10
        layout.itemSize = CGSize(width: self.view.bounds.width, height: cellHeight)
        layout.minimumLineSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
}

// MARK: - Actions
extension IssueListViewController {
    
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
            performSegue(withIdentifier: "createIssueFilterViewController", sender: self)
        case .edit:
            // TODO: SelectAll
            break
        }
    }
    
    @IBSegueAction func createIssueFilterViewController(_ coder: NSCoder) -> IssueFilterViewController? {
        if viewingMode == .edit { return nil }
        let vc = IssueFilterViewController(coder: coder)
        // TODO: Dependency Injection to IssueFilterViewController
        return vc
    }
    
    @IBAction func closeAllSelectedIssueButtonTapped(_ sender: Any) {
    
    }
    
    private func toEditMode() {
        viewingMode = .edit
        rightNavButton.setTitle("Cancle", for: .normal)
        leftNavButton.setTitle("Select All", for: .normal)
        bottomToolBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView else { return }
            cell.showCheckBox(show: true, animation: true)
        }
    }
    
    private func toGeneralMode() {
        viewingMode = .general
        rightNavButton.setTitle("Edit", for: .normal)
        leftNavButton.setTitle("Filter", for: .normal)
        bottomToolBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? IssueCellView else { return }
            cell.showCheckBox(show: false, animation: true)
        }
    }
}

// MARK: - UICollectionViewDataSource Implementation
extension IssueListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellView: IssueCellView = collectionView.dequeueCell(at: indexPath) else { return UICollectionViewCell() }
        cellView.configure()
        cellView.showCheckBox(show: viewingMode == .edit, animation: false)
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
}
