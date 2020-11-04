//
//  DetailFilterCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class DetailFilterCellView: UITableViewCell {
    
    private var component: CellComponentProtocol?
    
    func configure(type: ComponentStyle, viewModel: ConditionCellViewModel?) {
        guard let viewModel = viewModel else {
            component?.contentView.removeFromSuperview()
            return
        }
        
        if component == nil {
            configureComponent(type: type)
        }
        
        component?.configure(viewModel: viewModel)
        layoutIfNeeded()
    }
    
    private func configureComponent(type: ComponentStyle) {
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
            component.contentView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            component.contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
            component.contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
}
