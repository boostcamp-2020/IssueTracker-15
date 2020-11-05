//
//  CellComponentProtocol.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

enum ComponentStyle {
    case userInfo
    case milestone
    case label
}

protocol CellComponentProtocol {
    var contentView: UIView { get }
    func configure(viewModel: CellComponentViewModel)
    func prepareForReuse()
}

extension CellComponentProtocol {
    func prepareForReuse() { }
}
