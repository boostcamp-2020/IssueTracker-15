//
//  ViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/26.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var labelListViewModel: LabelListViewModelProtocol? {
        didSet {
            labelListViewModel?.didFetch = { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        labelListViewModel?.needFetchItems()
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(type: LabelCellView.self)
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 10)
        layout.minimumLineSpacing = 1
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
}

// MARK: - Action

extension LabelListViewController {
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        showSubmitFormView(type: .add)
    }
    
    private func showSubmitFormView(type: LabelSubmitFieldsView.SubmitFieldType) {
        guard let labelSubmitFieldsView = LabelSubmitFieldsView.createView(),
            let formView = SubmitFormViewController.createViewController(with: labelSubmitFieldsView)
            else { return }
        
        switch type {
        case .add:
            labelSubmitFieldsView.onSaveButtonTapped = labelListViewModel?.addNewLabel
        case .edit(let indexPath):
            labelSubmitFieldsView.configure(labelViewModel: labelListViewModel?.cellForItemAt(path: indexPath))
            labelSubmitFieldsView.onSaveButtonTapped = { (title, desc, colorCode) in
                self.labelListViewModel?.editLabel(at: indexPath, title: title, desc: desc, hexColor: colorCode)
            }
        }
        present(formView, animated: true, completion: nil)
    }
    
}

// MARK: - UICollectionViewDelegate Implementation

extension LabelListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showSubmitFormView(type: .edit(indexPath))
    }
    
}

// MARK: - UICollectionViewDataSource Implementation

extension LabelListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelListViewModel?.numberOfItem() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: LabelCellView = collectionView.dequeueCell(at: indexPath),
            let cellViewModel = labelListViewModel?.cellForItemAt(path: indexPath)
            else { return UICollectionViewCell() }
        cell.configure(with: cellViewModel)
        return cell
    }
    
}
