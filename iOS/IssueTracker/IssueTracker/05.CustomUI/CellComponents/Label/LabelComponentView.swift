//
//  LabelComponentView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelComponentView: UIView {

    @IBOutlet weak var labelBadge: BadgeLabelView!
    
}

// MARK: - CellComponentProtocol Implementation

extension LabelComponentView: CellComponentProtocol {
    
    var contentView: UIView { self }
    
    func configure(viewModel: CellComponentViewModel) {
        labelBadge.text = viewModel.title
        guard let colorCode = viewModel.element else { return }
        labelBadge.setBackgroundColor(colorCode.color)
        labelBadge.cornerRadiusRatio = 0.3
        labelBadge.setPadding(top: 5, left: 10, bottom: 5, right: 10)
        layoutIfNeeded()
    }
}

// MARK: - Load From Nib

extension LabelComponentView {
    static let componentID = "LabelComponentView"

    static func createView() -> LabelComponentView? {
        return Bundle.main.loadNibNamed(componentID, owner: self, options: nil)?.last as? LabelComponentView
    }
}
