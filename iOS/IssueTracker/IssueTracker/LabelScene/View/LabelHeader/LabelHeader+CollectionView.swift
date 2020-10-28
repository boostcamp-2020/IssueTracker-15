//
//  LabelHeader+CollectionView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension LabelHeaderView {
    static let headerID: String = "LabelHeaderView"
    
    static func register(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: headerID, bundle: .main),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerID)
    }
    
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> LabelHeaderView? {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: headerID,
                                                                     for: indexPath)
        return header as? LabelHeaderView
    }
}
