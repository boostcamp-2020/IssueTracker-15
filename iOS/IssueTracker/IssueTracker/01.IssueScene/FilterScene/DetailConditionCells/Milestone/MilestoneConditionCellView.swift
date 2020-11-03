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
    
    override func configure(viewModel: ConditionCellViewModel) {
        super.configure(viewModel: viewModel)
        milestoneLabel.text = viewModel.title
        if let dateStr = viewModel.element.dateForMilestoneViewModel?.stringForConditionCell {
            dueDateLabel.text = "Due by " + dateStr
        } else {
            dueDateLabel.text = "-"
        }
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
