//
//  BadgeLabelView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class BadgeLabelView: UILabel {

    var padding: UIEdgeInsets = UIEdgeInsets.zero
    var cornerRadiusRatio: CGFloat = 0
    
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func setBackgroundColor(_ color: CGColor) {
        layer.backgroundColor = color
    }
    
    func setBorder(width: CGFloat, color: CGColor) {
        layer.borderWidth = width
        layer.borderColor = color
    }
    
    override var intrinsicContentSize: CGSize {
        let contentSize = super.intrinsicContentSize
        let contentWidth = contentSize.width + padding.left + padding.right
        return CGSize(width: contentWidth, height: contentSize.height )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let boundSize = CGSize(width: intrinsicContentSize.width, height: bounds.height)
        layer.cornerRadius = boundSize.height / 2 * cornerRadiusRatio
        autoResizeFontWithHeight()
    }

}
