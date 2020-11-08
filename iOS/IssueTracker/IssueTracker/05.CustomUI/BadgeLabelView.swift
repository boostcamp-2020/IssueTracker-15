//
//  BadgeLabelView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class BadgeLabelView: UILabel {

    var contentInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }

    var cornerRadiusRatio: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        contentInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
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
        let contentWidth = contentSize.width + contentInsets.left + contentInsets.right
        return CGSize(width: contentWidth, height: contentSize.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2 * cornerRadiusRatio
        invalidateIntrinsicContentSize()
    }

}
