//
//  IssueDetailCellView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueDetailCellView: UICollectionViewCell {
       
    @IBOutlet weak var desc: UILabel!
    func configure(with text: String) {
        desc.text = text
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

extension IssueDetailCellView: UICollectionViewRegisterable {
    
    static var cellIdentifier: String {
        return "IssueDetailCellView"
    }
    
    static var cellNib: UINib {
        return UINib(nibName: "IssueDetailCellView", bundle: .main)
    }
    
}
