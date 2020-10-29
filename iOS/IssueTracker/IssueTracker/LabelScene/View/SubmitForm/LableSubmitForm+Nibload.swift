//
//  LableSubmitForm+Nibload.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension LabelSubmitFormView {
    static let labelSubmitFormID: String = "LabelSubmitFormView"
    
    static func createView() -> LabelSubmitFormView? {
        return Bundle.main.loadNibNamed(labelSubmitFormID, owner: self, options: nil)?.last as? LabelSubmitFormView
    }
}
