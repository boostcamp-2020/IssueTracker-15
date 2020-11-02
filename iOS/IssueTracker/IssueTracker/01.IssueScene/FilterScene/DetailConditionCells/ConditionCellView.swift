//
//  ConditionCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class ConditionCellView: UITableViewCell {
    
    var choosen: Bool = false
    @IBOutlet weak var checkImage: UIImageView!
    
    enum Constant {
        static let imageChecked = UIImage(systemName: "x.circle.fill")
        static let imageUnchecked = UIImage(systemName: "plus.circle")
        static let colorChecked = UIColor.link
        static let colorUnChecked = UIColor.gray
    }
    
    func configure() {
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
    }
    
    func setChoosen(_ choose: Bool) {
        choosen = choose
        checkImage.image = choose ? Constant.imageChecked : Constant.imageUnchecked
        checkImage.tintColor = choose ? Constant.colorChecked : Constant.colorUnChecked
    }
}
