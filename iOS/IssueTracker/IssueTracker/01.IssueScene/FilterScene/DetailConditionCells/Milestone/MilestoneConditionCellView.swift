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
        if let date = viewModel.element.datdForServer {
            dueDateLabel.text = "Due by " + date.stringForConditionCell
            if date < Date() {
                dueDateLabel.textColor = .red
            }
        } else {
            dueDateLabel.text = "-"
        }
    }
    
    override func prepareForReuse() {
        dueDateLabel.textColor = .black
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
