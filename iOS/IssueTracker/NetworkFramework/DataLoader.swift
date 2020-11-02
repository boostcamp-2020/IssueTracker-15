//
//  DataLoader.swift
//  NetworkFramework
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public class DataLoader<T: Decodable> {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    public func perform(with urlRequest: URLRequest, completionHandler: @escaping (_ response: T?) -> Void) {
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { return }
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    completionHandler(try JSONDecoder().decode(T.self, from: data))
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

public struct HTTPHeaders {
    public var headers = [String: String]()
    public init() { }
}

public class Request {
    public init() { }
    
    public func asURLRequest(url: URL, method: HTTPMethod, header: HTTPHeaders) -> URLRequest {
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        urlRequest.setHTTPHeader(header: header)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}

extension URLRequest {
    mutating func setHTTPHeader(header: HTTPHeaders) {
        header.headers.forEach { header in
            self.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
}

protocol URLConvertible {
    func asURL() throws -> URL
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.invalidURL(self) }
        return url
    }
}

enum NetworkError: Error {
    case invalidURL(String)
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}
