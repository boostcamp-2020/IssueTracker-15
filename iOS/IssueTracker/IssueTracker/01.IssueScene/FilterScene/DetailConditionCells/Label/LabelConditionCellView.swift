//
//  LabelConditionCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelConditionCellView: ConditionCellView {
    
    @IBOutlet weak var labelBadge: BadgeLabelView!
    
    // TODO: LabelViewModel
     override func configure() {
        super.configure()
         // 임시
        labelBadge.text = "Feature"
        labelBadge.setBackgroundColor(UIColor.cyan.cgColor)
        labelBadge.cornerRadiusRatio = 0.3
        labelBadge.setPadding(top: 5, left: 10, bottom: 5, right: 10)
     }
    
}

// MARK: - UITableViewRegistable Implementation
extension LabelConditionCellView: UITableViewRegisterable {
    static var cellIdentifier: String {
        return "LabelConditionCellView"
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}
