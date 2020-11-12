//
//  UIImage+CornerRadius.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension UIView {
    func setRound(ratio: CGFloat) {
        let cornerRadius = ratio.clamp(min: 0, max: 1) * bounds.height * 1 / 2
        self.layer.cornerRadius = cornerRadius
    }
}
