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
    
    override func configure(viewModel: ConditionCellViewModel) {
        super.configure(viewModel: viewModel)
        labelBadge.text = viewModel.title
        labelBadge.setBackgroundColor(viewModel.element.color)
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
