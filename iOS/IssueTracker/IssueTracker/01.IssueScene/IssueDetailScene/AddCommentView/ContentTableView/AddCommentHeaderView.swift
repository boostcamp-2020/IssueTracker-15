//
//  AddCommentHeaderView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/09.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class AddCommentHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}

// MARK: - loadNIB extension
extension AddCommentHeaderView {
    static let identifier = "AddCommentHeaderView"
    static func createView() -> AddCommentHeaderView? {
        return Bundle.main.loadNibNamed(AddCommentHeaderView.identifier, owner: self, options: nil)?.last as? AddCommentHeaderView
    }
}
