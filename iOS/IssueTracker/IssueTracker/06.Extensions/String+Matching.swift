//
//  String+ContainRegex.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension String {
    
    enum RegexPattern {
        // yyyy-MM-dd
        case milestoneFormDate
        
        var patternString: String {
            switch self {
            case .milestoneFormDate:
                return "(19|20)\\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])"
            }
        }
    }
    
    func contains(regexPattern: RegexPattern) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regexPattern.patternString) else { return false }
        let range = NSRange(location: 0, length: utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
            }
    
    func numberOfMatches(of str: String) -> Int {
        guard let regex = try? NSRegularExpression(pattern: str, options: .caseInsensitive) else { return 0 }
        let nsRange = NSRange(location: 0, length: self.utf16.count)
        return regex.numberOfMatches(in: self, range: nsRange)
    }
    
}
