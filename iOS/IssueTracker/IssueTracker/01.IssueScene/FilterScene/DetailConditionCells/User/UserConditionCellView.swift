//
//  AsigneeCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class UserConditionCellView: ConditionCellView {

    @IBOutlet weak var userImageLabel: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    // TODO: UserInfo
    override func configure() {
        super.configure()
        // 임시
        userNameLabel.text = "SHIVVVPP"
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userNameLabel.autoResizeFontWithHeight()
    }
    
}

// MARK: - UITableViewRegistable Implementation
extension UserConditionCellView: UITableViewRegisterable {
    static var cellIdentifier: String {
        return "UserConditionCellView"
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}
