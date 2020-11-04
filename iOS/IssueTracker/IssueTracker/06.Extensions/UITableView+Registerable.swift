//
//  UITableView+.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

protocol UITableViewRegisterable {
    static var cellIdentifier: String { get }
    static var cellNib: UINib { get }
}

extension UITableView {
    func register(type: UITableViewRegisterable.Type) {
        register(type.cellNib, forCellReuseIdentifier: type.cellIdentifier)
    }

    func dequeueCell<CellType: UITableViewRegisterable>(at indexPath: IndexPath) -> CellType? {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.cellIdentifier, for: indexPath) as? CellType else {
            return nil
        }
        return cell
    }
}
