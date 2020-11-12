//
//  MilestoneComponentView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MilestoneComponentView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.autoResizeFontWithHeight()
        dueDateLabel.autoResizeFontWithHeight()
    }
    
}

// MARK: - CellComponentProtocol Implementation

extension MilestoneComponentView: CellComponentProtocol {
    
    var contentView: UIView { self }
    
    func configure(viewModel: CellComponentViewModel) {
        titleLabel.text = viewModel.title
        if let date = viewModel.element?.datdForServer {
            dueDateLabel.text = "Due by " + date.stringForConditionCell
            if date < Date() {
                dueDateLabel.textColor = .red
            }
        } else {
            dueDateLabel.text = "-"
        }
    }
    
    func prepareForReuse() {
        dueDateLabel.textColor = .black
    }
    
}

// MARK: - Load From Nib

extension MilestoneComponentView {
    static let componentID = "MilestoneComponentView"

    static func createView() -> MilestoneComponentView? {
        return Bundle.main.loadNibNamed(componentID, owner: self, options: nil)?.last as? MilestoneComponentView
    }
}
