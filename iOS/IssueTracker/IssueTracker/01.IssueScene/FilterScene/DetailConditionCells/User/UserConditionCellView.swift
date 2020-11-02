//
//  AsigneeCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class UserConditionCellView: UITableViewCell {

    enum Constant {
        static let imageOnSelected = UIImage(systemName: "plus.circle")
        static let imageOutSelected = UIImage(systemName: "x.circle.fill")
        static let colorOnSelected = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        static let colorOutSelected = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    @IBOutlet weak var userImageLabel: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var accessoryImage: UIImageView!
    
   // TODO: UserInfo
    func configure() {
        // 임시
        userNameLabel.text = "SHIVVVPP"
        selectionStyle = .none
        layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
    }
    
    override func layoutSubviews() {
        userNameLabel.autoResizeFontWithHeight()
    }
    
    var isChoosen : Bool = false {
        didSet {
            accessoryImage.image = isSelected ? Constant.imageOnSelected : Constant.imageOutSelected
            accessoryImage.tintColor = isSelected ? Constant.colorOnSelected : Constant.colorOutSelected
        }
    }
    
}

// MARK: - UITableViewRegistable Implementation
extension UserConditionCellView: UITableViewRegisterable {
    static var cellIdentifier: String {
        return "UserConditionCellView"
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}
