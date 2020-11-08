//
//  MilestoneListViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MilestoneListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var milestoneListViewModel: MilestoneListViewModelProtocol? {
        didSet {
            milestoneListViewModel?.didFetch = { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        milestoneListViewModel?.needFetchItems()
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(type: MilestoneCellView.self)
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 8)
        layout.minimumLineSpacing = 1
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - Action

extension MilestoneListViewController {
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        showSubmitFormView(type: .add)
    }
    
    private func showSubmitFormView(type: MilestoneSubmitFieldsView.SubmitFieldType) {
        guard let tabBarController = self.tabBarController,
            let formView = SubmitFormView.createView(),
            let milestoneSubmitFieldsView = MilestoneSubmitFieldsView.createView()
            else { return }
        
        formView.configure(submitField: milestoneSubmitFieldsView)
        
        switch type {
        case .add:
            milestoneSubmitFieldsView.onSaveButtonTapped = milestoneListViewModel?.addNewMileStone
        case .edit(let indexPath):
            milestoneSubmitFieldsView.configure(milestoneItemViewModel: milestoneListViewModel?.cellForItemAt(path: indexPath))
            milestoneSubmitFieldsView.onSaveButtonTapped = { (title, dueDate, desc) in
                self.milestoneListViewModel?.editMileStone(at: indexPath, title: title, description: desc, dueDate: dueDate)
            }
        }
        
        tabBarController.view.addSubview(formView)
        formView.frame = tabBarController.view.frame
    }
    
}

// MARK: - UICollectionViewDelegate Implementation

extension MilestoneListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showSubmitFormView(type: .edit(indexPath))
    }
    
}

// MARK: - UICollectionViewDataSource Implementation

extension MilestoneListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return milestoneListViewModel?.numberOfItem() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MilestoneCellView = collectionView.dequeueCell(at: indexPath),
            let cellViewModel = milestoneListViewModel?.cellForItemAt(path: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: cellViewModel)
        return cell
    }
    
}
