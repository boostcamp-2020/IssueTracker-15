//
//  IssueDetailCellView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueDetailCellView: UICollectionViewCell {
       
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var createAt: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    func configure(with comment: CommentViewModel) {
        content.text = comment.content
        author.text = comment.userName
        createAt.text = comment.createAt
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
