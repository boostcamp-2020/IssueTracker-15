//
//  UserInfoComponentView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class UserInfoComponentView: UIView {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        userNameLabel.autoResizeFontWithHeight()
    }
}

// MARK: - CellComponentProtocol Implementation

extension UserInfoComponentView: CellComponentProtocol {
    
    var contentView: UIView { self }
    
    func configure(viewModel: CellComponentViewModel) {
        // TODO: configure UserInfo
        userNameLabel.text = viewModel.title
        layoutIfNeeded()
    }
    
}

// MARK: - Load From Nib

extension UserInfoComponentView {
    static let componentID = "UserInfoComponentView"

    static func createView() -> UserInfoComponentView? {
        return Bundle.main.loadNibNamed(componentID, owner: self, options: nil)?.last as? UserInfoComponentView
    }
}
