//
//  MilestoneSubmitFieldsView+LoadFromNib.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/31.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension MilestoneSubmitFieldsView {
    
    static let milestoneSubmitFieldsID: String = "MilestoneSubmitFieldsView"
    
    static func createView() -> MilestoneSubmitFieldsView? {
        return Bundle.main.loadNibNamed(milestoneSubmitFieldsID, owner: self, options: nil)?.last as? MilestoneSubmitFieldsView
    }
    
}
