//
//  SubmitFormView+LoadFromNib.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension SubmitFormView {
    static let SubmitFormViewID = "SubmitFormView"

    static func createView() -> SubmitFormView? {
        return Bundle.main.loadNibNamed(SubmitFormViewID, owner: self, options: nil)?.last as? SubmitFormView
    }
}
