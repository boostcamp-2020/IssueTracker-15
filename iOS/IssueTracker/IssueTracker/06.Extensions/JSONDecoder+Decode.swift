//
//  JSONDecoder+Decode.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }
    
}
