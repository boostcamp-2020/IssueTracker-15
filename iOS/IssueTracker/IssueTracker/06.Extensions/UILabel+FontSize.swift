//
//  UILabel+FontSize.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension UILabel {
    func autoResizeFontWithHeight() {
        font = font.withSize(self.adjustedFontSizeWithHeight())
    }
    
    func adjustedFontSizeWithHeight() -> CGFloat {
        guard let textSize = text?.size(withAttributes: [.font: font!]) else { return font.pointSize }
        
        let numOfLines = numberOfLines > 0 ? CGFloat(numberOfLines) : 1
        let scale = bounds.height / (textSize.height * numOfLines)
        let actualFontSize = scale * font.pointSize
        
        return actualFontSize
    }
}
