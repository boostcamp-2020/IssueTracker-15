//
//  Int+Clamp.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/01.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension CGFloat {
    
    func clamp(min: CGFloat, max: CGFloat) -> CGFloat {
        let result = self < min ? min : self
        return result > max ? max : result
    }
    
}
