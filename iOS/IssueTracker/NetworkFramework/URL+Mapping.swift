//
//  URL+Mapping.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

extension URL {
    init(target: Target) throws {
        
        var basComponent: URLComponents?
        if target.path.isEmpty {
            basComponent = URLComponents(url: target.baseURL, resolvingAgainstBaseURL: false)
        } else {
            basComponent = URLComponents(url: target.baseURL.appendingPathComponent(target.path), resolvingAgainstBaseURL: false)
        }
        
        guard var urlComponent = basComponent else { throw NetworkError.endPointMaappingError("urlComponent 생성 실패") }
        if let queryItems = target.queryItems {
            urlComponent.queryItems = queryItems.reduce(into: []) {
                $0.append(URLQueryItem(name: $1.key, value: $1.value))
            }
        }
        
        if let url = urlComponent.url {
            self = url
        } else {
            throw NetworkError.endPointMaappingError("urlComponent url 변환 실패")
        }
        
    }
}
