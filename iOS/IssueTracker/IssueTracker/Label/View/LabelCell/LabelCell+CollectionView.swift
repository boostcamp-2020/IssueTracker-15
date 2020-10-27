//
//  LabelCell+CollectionView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension LabelCellView {
    static let cellID = "LabelCellView"
    
    static func register(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: cellID, bundle: .main), forCellWithReuseIdentifier: cellID)
    }
    
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> LabelCellView? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell as? LabelCellView
    }
}
