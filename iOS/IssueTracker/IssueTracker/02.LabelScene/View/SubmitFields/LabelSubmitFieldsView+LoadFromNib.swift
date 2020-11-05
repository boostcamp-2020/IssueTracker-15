//
//  LabelSubmitFieldsView+LoadFromNib.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension LabelSubmitFieldsView {
    
    static let labelSubmitFieldsView: String = "LabelSubmitFieldsView"
    
    static func createView() -> LabelSubmitFieldsView? {
        return Bundle.main.loadNibNamed(labelSubmitFieldsView, owner: self, options: nil)?.last as? LabelSubmitFieldsView
    }
    
}
