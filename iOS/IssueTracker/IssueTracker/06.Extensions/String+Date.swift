//
//  String+Date.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension String {
    var datdForServer: Date? {
        print("string formatting : \(self)")
        return DateFormatter.datdFromServer.date(from: self)
    }
    
    var dateForSubmitForm: Date? {
        print("string formatting : \(self)")
        return DateFormatter.dateForSubmitForm.date(from: self)
    }
}
