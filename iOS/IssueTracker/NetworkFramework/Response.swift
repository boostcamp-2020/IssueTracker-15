//
//  Response.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/07.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public class Response {
    public let statusCode: Int
    public let data: Data
    public let request: URLRequest?
    public let response: HTTPURLResponse?
    
    public init(statusCode: Int, data: Data, request: URLRequest? = nil, response: HTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
}

extension Response {
    public func mapEncodable<T: Decodable>(_ type: T.Type) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }
    
    public func mapJsonObject() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
    
    public func mapJsonArr() -> [[String: Any]]? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
    }
}

extension Response {
    public static func convertToResponse(response: URLResponse?,
                                         request: URLRequest,
                                         data: Data?,
                                         error: Error?) -> Result<Response, NetworkError> {
        let response = response as? HTTPURLResponse
        switch (response, data, error) {
        case let (.some(response), data, .none):
            let response = Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
            return .success(response)
        case let (.some(response), _, .some(error)):
            let response = Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
            let error = NetworkError.underlying(error, response)
            return .failure(error)
        case let (_, _, .some(error)):
            let error = NetworkError.underlying(error, nil)
            return .failure(error)
        default:
            let error = NetworkError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), nil)
            return .failure(error)
        }
    }
}
