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
    
    var bottomSheetCellType: DetailSelectionType = .assignee
    var onHeaderViewTapped: ((DetailSelectionType) -> Void)?
    
    func configure(type: DetailSelectionType) {
        bottomSheetCellType = type
        titleLabel.text = type.title
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func headerViewTapped() {
        onHeaderViewTapped?(bottomSheetCellType)
    }
}

// MARK: - loadNIB extension

extension BottomSheetHeaderView {
    
    static let identifier = "BottomSheetHeaderView"
    
    static func createView() -> BottomSheetHeaderView? {
        return Bundle.main.loadNibNamed(BottomSheetHeaderView.identifier, owner: self, options: nil)?.last as? BottomSheetHeaderView
    }
    
}
