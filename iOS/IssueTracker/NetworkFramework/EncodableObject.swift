//
//  EncodableObject.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct EncodableObject: Encodable {
    
    private let object: Encodable
    
    public init(_ object: Encodable) {
        self.object = object
    }
    
    func encode(to encoder: Encoder) throws {
        try object.encode(to: encoder)
    }
    
}
