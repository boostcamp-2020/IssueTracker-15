//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelCellView: UICollectionViewCell {
    @IBOutlet weak var titleLabel: BadgeLabelView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with currentItem: LabelItemViewModel) {
        configureTitle(text: currentItem.title, color: currentItem.hexColor.color)
        configureDescription(with: currentItem.description)
    }
    
    func configureTitle(text: String, color: CGColor) {
        titleLabel.text = text
        titleLabel.setBackgroundColor(color)
        titleLabel.cornerRadiusRatio = 0.5
        titleLabel.setPadding(top: 3, left: 5, bottom: 3, right: 5)
        titleLabel.fitSizeWithBounds()
    }
    
    func configureDescription(with description: String) {
        descriptionLabel.text = description
        descriptionLabel.textColor = UIColor.lightGray
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
}