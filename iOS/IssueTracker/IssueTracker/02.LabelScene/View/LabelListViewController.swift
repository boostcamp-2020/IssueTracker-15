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
    var labelListViewModel: LabelListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureLabelListViewModel()
        labelListViewModel?.needFetchItems()
    }
    
    private func configureLabelListViewModel() {
        labelListViewModel?.didFetch = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(type: LabelCellView.self)
        HeaderView.register(in: collectionView)
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 10)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 12)
        layout.minimumLineSpacing = 1
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        showSubmitFormView()
    }

    private func showSubmitFormView(indexPath: IndexPath? = nil) {
        guard let tabBarController = self.tabBarController,
            let formView = SubmitFormView.createView(),
            let labelSubmitFieldsView = LabelSubmitFieldsView.createView()
            else { return }
        
        formView.configure(submitField: labelSubmitFieldsView)
        
        if let indexPath = indexPath {
            labelSubmitFieldsView.configure(labelViewModel: labelListViewModel?.cellForItemAt(path: indexPath))
            labelSubmitFieldsView.onSaveButtonTapped = { (title, desc, colorCode) in
                self.labelListViewModel?.editLabel(at: indexPath, title: title, desc: desc, hexColor: colorCode)
            }
        } else {
            labelSubmitFieldsView.onSaveButtonTapped = labelListViewModel?.addNewLabel
        }
        
        tabBarController.view.addSubview(formView)
        formView.frame = tabBarController.view.frame
    }
    
}

extension LabelListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelListViewModel?.numberOfItem() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: LabelCellView = collectionView.dequeueCell(at: indexPath),
            let cellViewModel = labelListViewModel?.cellForItemAt(path: indexPath)
            else { return UICollectionViewCell() }
        
        cell.configure(with: cellViewModel)
        cell.nextButtonTapped = { [weak self] in
            self?.showSubmitFormView(indexPath: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = HeaderView.dequeue(from: collectionView, for: indexPath) else { return UICollectionReusableView() }
        
        header.configure(title: "레이블")
        
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
