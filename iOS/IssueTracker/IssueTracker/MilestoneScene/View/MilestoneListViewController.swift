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
    var milestoneListViewModel: MilestoneListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureMilestoneListViewModel()
        milestoneListViewModel?.needFetchItems()
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        MilestoneCellView.register(in: collectionView)
        HeaderView.register(in: collectionView)
    }
    
    private func configureMilestoneListViewModel() {
        milestoneListViewModel?.didFetch = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 8)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 12)
        layout.minimumLineSpacing = 1
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension MilestoneListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return milestoneListViewModel?.numberOfItem() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = MilestoneCellView.dequeue(from: collectionView, for: indexPath), let cellViewModel = milestoneListViewModel?.cellForItemAt(path: indexPath) else { return UICollectionViewCell() }
        
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = HeaderView.dequeue(from: collectionView, for: indexPath) else { return UICollectionReusableView() }
        
        header.configure(title: "마일스톤")
        
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
