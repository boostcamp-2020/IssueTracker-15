//
//  AddCommentHeaderView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/09.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class BottomSheetHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}

// MARK: - loadNIB extension
extension BottomSheetHeaderView {
    static let identifier = "BottomSheetHeaderView"
    static func createView() -> BottomSheetHeaderView? {
        return Bundle.main.loadNibNamed(BottomSheetHeaderView.identifier, owner: self, options: nil)?.last as? BottomSheetHeaderView
    }
}
