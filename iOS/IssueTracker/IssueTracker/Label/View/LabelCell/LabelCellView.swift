//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelCellView: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with currentItem: Label) {
        configureTitle(text: currentItem.title, color: currentItem.hexColor.color)
        configureDescription(with: currentItem.description)
    }
    
    func configureTitle(text: String, color: CGColor) {
        titleLabel.text = text
        titleLabel.layer.backgroundColor = color
    }
    
    func configureDescription(with description: String) {
        descriptionLabel.text = description
        descriptionLabel.textColor = UIColor.lightGray
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
}
