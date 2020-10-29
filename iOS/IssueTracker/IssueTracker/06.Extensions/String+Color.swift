//
//  String+Color.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var color: CGColor {
        var tempString: String = self
        
        if self.hasPrefix("#") {
            tempString.remove(at: tempString.startIndex)
        }
        
        if tempString.count != 6 {
            return CGColor.init(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: tempString).scanHexInt64(&rgbValue)

        return CGColor(srgbRed: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: CGFloat(1.0))
        
    }
}
