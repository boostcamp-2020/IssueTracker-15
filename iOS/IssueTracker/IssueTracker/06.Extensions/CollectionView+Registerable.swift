//
//  CollectionView+.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

protocol UICollectionViewHeaderRegisterable {
    static var headerIdentifier: String { get }
    static var headerNib: UINib { get }
}

protocol UICollectionViewRegisterable {
    static var cellIdentifier: String { get }
    static var cellNib: UINib { get }
}

extension UICollectionView {
    func registerHeader(type: UICollectionViewHeaderRegisterable.Type) {
        register(type.headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.headerIdentifier)
    }
    
    func dequeueHeader<HeaderType: UICollectionViewHeaderRegisterable>(at indexPath: IndexPath) -> HeaderType? {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderType.headerIdentifier, for: indexPath) as? HeaderType else {
            return nil
        }
        return header
    }
    
    func registerCell(type: UICollectionViewRegisterable.Type) {
        register(type.cellNib, forCellWithReuseIdentifier: type.cellIdentifier)
    }

    func dequeueCell<CellType: UICollectionViewRegisterable>(at indexPath: IndexPath) -> CellType? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellType.cellIdentifier, for: indexPath) as? CellType else {
            return nil
        }
        return cell
    }
}
