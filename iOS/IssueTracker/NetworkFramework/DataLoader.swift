//
//  DataLoader.swift
//  NetworkFramework
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public typealias RequestResult<T> = Result<T?, NetworkError>

public protocol DataLodable: AnyObject {
    func request<T: Decodable>(_ type: T.Type, endpoint: EndPoint, completion: @escaping (RequestResult<T>) -> Void)
}

public class DataLoader: DataLodable {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func request<T>(_ type: T.Type, endpoint: EndPoint, completion: @escaping (RequestResult<T>) -> Void) where T : Decodable {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.port = endpoint.port
        components.path = endpoint.path
        print(components)
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.httpBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print(urlRequest)
        print(String(data: urlRequest.httpBody ?? Data() , encoding: .utf8))
        print(urlRequest.httpMethod)
        print(urlRequest.allHTTPHeaderFields)
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == endpoint.statusCode else {
                completion(.failure(.responseError("요청에 실패했습니다.")))
                return
            }
            
            if let data = data {
                do {
                     let dataString = String(data: data, encoding: .utf8)
                     print("data string : \(dataString!)")
                     print("response status code : \(response.statusCode)")
                    
                    if endpoint.method == .delete || endpoint.method == .patch {
                        completion(.success(nil))
                    } else {
                        completion(.success(try JSONDecoder().decode(T.self, from: data)))
                    }
                } catch {
                    print(NetworkError.decodingError("\(T.Type.self)"))
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

public enum NetworkError: Error {
    case invalidURL(String)
    case decodingError(String)
    case responseError(String)
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol EndPoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var httpBody: Data? { get }
    var port: Int { get }
    var statusCode: Int { get }
}
