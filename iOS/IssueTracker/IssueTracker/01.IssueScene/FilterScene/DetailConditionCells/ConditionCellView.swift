//
//  ConditionCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class ConditionCellView: UITableViewCell {
    
    @IBOutlet weak var checkImage: UIImageView!
    
    private var component: CellComponentProtocol?
    
    enum Constant {
        static let imageChecked = UIImage(systemName: "x.circle.fill")
        static let imageUnchecked = UIImage(systemName: "plus.circle")
        static let colorChecked = UIColor.gray
        static let colorUnChecked = UIColor.link
    }
    
    func configure(type: DetailFilterViewController.ContentMode, viewModel: ConditionCellViewModel) {
        if component == nil {
            configureComponent(type: type)
        }
        component?.configure(viewModel: viewModel)
        layoutIfNeeded()
    }
    
    private func configureComponent(type: DetailFilterViewController.ContentMode) {
        switch type {
        case .userInfo:
            component = UserInfoComponentView.createView()
        case .milestone:
            component = MilestoneComponentView.createView()
        case .label:
            component = LabelComponentView.createView()
        }
        guard let component = component else { return }
        
        addSubview(component.contentView)
        NSLayoutConstraint.activate([
            component.contentView.topAnchor.constraint(equalTo: topAnchor),
            component.contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            component.contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            component.contentView.rightAnchor.constraint(lessThanOrEqualTo: checkImage.leftAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        component?.prepareForReuse()
    }
    
    func setCheck(_ check: Bool) {
        checkImage.image = check ? Constant.imageChecked : Constant.imageUnchecked
        checkImage.tintColor = check ? Constant.colorChecked : Constant.colorUnChecked
    }
}

// MARK: - UITableViewRegistable Implementation

extension ConditionCellView: UITableViewRegisterable {
    static var cellIdentifier: String {
        return "ConditionCellView"
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}
