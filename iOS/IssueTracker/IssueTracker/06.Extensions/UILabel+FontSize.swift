//
//  UILabel+FontSize.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

extension UILabel {
    func configureFontSize() {
        self.font = self.font.withSize(self.bounds.height - 1)
    }
}
