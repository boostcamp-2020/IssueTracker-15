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
    
    private var labelListViewModel: LabelListViewModelProtocol = LabelListViewModel()
    
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
    
    private func showSubmitFormView(indexPath: IndexPath? = nil) {
        guard let tabBarController = self.tabBarController, let labelSubmitFormView = LabelSubmitFormView.createView() else { return }
        
        if let indexPath = indexPath {
            labelSubmitFormView.configure(labelViewModel: labelListViewModel.cellForItemAt(path: indexPath))
            labelSubmitFormView.submitbuttonTapped = { (title, description, hexColor) in
                self.labelListViewModel.editLabel(at: indexPath, title: title, desc: description, hexColor: hexColor)
            }
        } else {
            labelSubmitFormView.configure()
            labelSubmitFormView.submitbuttonTapped = self.labelListViewModel.addNewLabel
        }
        
        tabBarController.view.addSubview(labelSubmitFormView)
        labelSubmitFormView.frame = tabBarController.view.frame
    }
    
}

extension LabelListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelListViewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = LabelCellView.dequeue(from: collectionView, for: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: labelListViewModel.cellForItemAt(path: indexPath))
        cell.nextButtonTapped = { [weak self] in
            self?.showSubmitFormView(indexPath: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = LabelHeaderView.dequeue(from: collectionView, for: indexPath) else { return UICollectionReusableView() }
        
        header.plusButtonTapped = { [weak self] in
            self?.showSubmitFormView()
        }
        
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
