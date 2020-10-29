//
//  MilestoneSubmitForm+NibLoad.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension MilestoneSubmitFormView {
    static let submitFormID: String = "MilestoneSubmitFormView"
    
    static func createView() -> MilestoneSubmitFormView? {
        return Bundle.main.loadNibNamed(submitFormID, owner: self, options: nil)?.last as? MilestoneSubmitFormView
    }
}
