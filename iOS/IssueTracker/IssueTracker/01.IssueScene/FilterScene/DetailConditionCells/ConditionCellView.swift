//
//  ConditionCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class ConditionCellView: UITableViewCell {
    
    private var checked: Bool = false
    @IBOutlet weak var checkImage: UIImageView!
    
    enum Constant {
        static let imageChecked = UIImage(systemName: "x.circle.fill")
        static let imageUnchecked = UIImage(systemName: "plus.circle")
        static let colorChecked = UIColor.gray
        static let colorUnChecked = UIColor.link
    }
    
    func configure(viewModel: ConditionCellViewModel) {
        selectionStyle = .none
    }
    
    func setCheck(_ check: Bool) {
        checked = check
        checkImage.image = checked ? Constant.imageChecked : Constant.imageUnchecked
        checkImage.tintColor = checked ? Constant.colorChecked : Constant.colorUnChecked
    }
}
