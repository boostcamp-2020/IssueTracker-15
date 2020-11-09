//
//  URLRequest+Encoding.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func encoding(encodable: Encodable) throws -> URLRequest {
        do {
            let encodableObject = EncodableObject(encodable)
            httpBody = try JSONEncoder().encode(encodableObject)
            
            if value(forHTTPHeaderField: "Content-Type") == nil {
                setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            return self
        } catch {
            throw NetworkError.encodingData(error)
        }
    }
    
    mutating func encoding(jsonObject: [String: Any]) throws -> URLRequest {
        do {
            httpBody = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            
            if value(forHTTPHeaderField: "Content-Type") == nil {
                setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            return self
        } catch {
            throw NetworkError.encodingData(error)
        }
    }
    
}
