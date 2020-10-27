//
//  ViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/26.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelListViewController: UIViewController {
    let tempLabels: [Label] = [Label(title: "feature", description: "기능에 대한 레이블입니다.", hexColor: "#FF5D5D"),
                               Label(title: "bug", description: "수정할 버그에 대한 레이블입니다.", hexColor: "#96F879")]
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 10)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 6.5)
        layout.minimumLineSpacing = 1
        layout.sectionHeadersPinToVisibleBounds = true
        
        return layout
    }()
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        LabelCellView.register(in: collectionView)
        LabelHeaderView.register(in: collectionView)
    }
}

extension LabelListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = LabelCellView.dequeue(from: collectionView, for: indexPath) else { return UICollectionViewCell() }
        
        let currentItem = tempLabels[indexPath.row]
        cell.configure(with: currentItem)
        
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
