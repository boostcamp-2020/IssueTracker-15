//
//  ViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/26.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelListViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var labelListViewModel: LabelsViewModelProtocol = LabelsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureLabelsViewModel()
        labelListViewModel.needFetchItems()
    }
    
    private func configureLabelsViewModel() {
        labelListViewModel.didFetch = { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        LabelCellView.register(in: collectionView)
        LabelHeaderView.register(in: collectionView)
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 10)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 6.5)
        layout.minimumLineSpacing = 1
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
}

extension LabelListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelListViewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = LabelCellView.dequeue(from: collectionView, for: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: labelListViewModel.cellForItemAt(path: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = LabelHeaderView.dequeue(from: collectionView, for: indexPath) else { return UICollectionReusableView() }
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
