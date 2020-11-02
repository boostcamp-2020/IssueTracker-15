//
//  MilestoneConditionCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MilestoneConditionCellView: ConditionCellView {

    @IBOutlet weak var milestoneLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    // TODO: MilestoneViewModel
    override func configure() {
        super.configure()
        // 임시
        milestoneLabel.text = "스프린트 2"
        dueDateLabel.text = "Due by November 5, 2020"
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        milestoneLabel.autoResizeFontWithHeight()
        dueDateLabel.autoResizeFontWithHeight()
    }
    
}

// MARK: - UITableViewRegistable Implementation
extension MilestoneConditionCellView: UITableViewRegisterable {
    static var cellIdentifier: String {
        return "MilestoneConditionCellView"
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}
