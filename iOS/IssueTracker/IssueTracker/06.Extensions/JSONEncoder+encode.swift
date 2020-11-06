//
//  JSONEncoder+encode.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension JSONEncoder {

    static func encode<T: Encodable>(data: T) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(data)
    }
    
}
