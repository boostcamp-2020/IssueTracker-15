//
//  UIColor+LabelTextColor.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/13.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension UIColor {
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}
