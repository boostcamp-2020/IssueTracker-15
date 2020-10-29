//
//  MilestoneCellView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MilestoneCellView: UICollectionViewCell {
    @IBOutlet weak var titleLabel: BadgeLabelView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var openedIssueLabel: UILabel!
    @IBOutlet weak var closedIssueLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        descriptionLabel.configureFontSize()
        dateLabel.configureFontSize()
        openedIssueLabel.configureFontSize()
        closedIssueLabel.configureFontSize()
    }
    
    func configure(with currentItem: MilestoneItemViewModel) {
        configureTitle(text: currentItem.title)
        configureDescription(with: currentItem.description)
        configureDate(with: currentItem.dueDateText)
        configureOpenedIssue(with: currentItem.openIssue)
        configureCloseddIssue(with: currentItem.closedIssue)
    }
    
    private func configureTitle(text: String) {
        titleLabel.text = text
        titleLabel.setBorder(width: 1, color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        titleLabel.cornerRadiusRatio = 0.5
        titleLabel.setPadding(top: 5, left: 5, bottom: 5, right: 5)
        titleLabel.fitSizeWithBounds()
    }
    
    private func configureDescription(with description: String) {
        descriptionLabel.text = description
    }
    
    private func configureDate(with date: String) {
        dateLabel.text = date
    }
    
    private func configureOpenedIssue(with openedIssue: String) {
        openedIssueLabel.text = openedIssue
    }
    
    private func configureCloseddIssue(with closedIssue: String) {
        closedIssueLabel.text = closedIssue
    }
}
