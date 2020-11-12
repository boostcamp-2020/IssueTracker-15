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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    func configure(with currentItem: LabelItemViewModel) {
        configureTitle(text: currentItem.title, color: currentItem.hexColor.color)
        configureDescription(with: currentItem.description)
    }
    
    func configureTitle(text: String, color: CGColor) {
        let uiColor = UIColor(cgColor: color)
        
        titleLabel.text = text
        titleLabel.textColor = uiColor.isDarkColor ? UIColor.white : UIColor.black
        titleLabel.setBackgroundColor(color)
        titleLabel.cornerRadiusRatio = 0.5
        titleLabel.setPadding(top: 3, left: 5, bottom: 3, right: 5)
    }
    
    func configureDescription(with description: String) {
        descriptionLabel.text = description
        descriptionLabel.textColor = UIColor.lightGray
    }
    
}

// MARK: - UICollectionViewRegisterable Implementation

extension LabelCellView: UICollectionViewRegisterable {
    static var cellIdentifier: String {
        return "LabelCellView"
    }

    static var cellNib: UINib {
        return UINib(nibName: "LabelCellView", bundle: nil)
    }
}

extension UIColor {
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}
