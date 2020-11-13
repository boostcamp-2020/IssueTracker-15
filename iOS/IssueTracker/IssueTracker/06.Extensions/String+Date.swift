//
//  String+Date.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension String {
    var dateForServer: Date? {
        return DateFormatter.datdFromServer.date(from: self)
    }
    
    var dateForSubmitForm: Date? {
        return DateFormatter.dateForSubmitForm.date(from: self)
    }
}
