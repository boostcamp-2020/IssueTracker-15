//
//  AssigneeCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/09.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class AddCommentLabelCollectionView: UITableViewCell {

    private lazy var userComponentView: UserInfoComponentView? = {
        return UserInfoComponentView.createView()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let userComponentView = userComponentView else { return }
        
    }

    func configure(with viewModel: UserViewModel) {
        
    }
    
}
