//
//  CollectionView+.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

protocol UICollectionViewRegisterable {
    static var cellIdentifier: String { get }
    static var cellNib: UINib { get }
}

extension UICollectionView {
    func register(type: UICollectionViewRegisterable.Type) {
        register(type.cellNib, forCellWithReuseIdentifier: type.cellIdentifier)
    }

    func dequeueCell<CellType: UICollectionViewRegisterable>(at indexPath: IndexPath) -> CellType? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellType.cellIdentifier, for: indexPath) as? CellType else {
            return nil
        }
        return cell
    }
}
