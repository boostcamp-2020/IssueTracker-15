//
//  DataLoader.swift
//  NetworkFramework
//
//  Created by sihyung you on 2020/11/02.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public typealias Completion = (_ result: Result<Response, NetworkError>) -> Void
public typealias RequestCompletion =  (Data?, URLResponse?, Error?) -> Void

public protocol DataLoadable: AnyObject {
    func request(_ target: Target, callBackQueue: DispatchQueue?, completion: @escaping Completion)
}

public class DataLoader: DataLoadable {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func request(_ target: Target, callBackQueue: DispatchQueue? = .none, completion: @escaping Completion) {
        let endPoint = EndPoint.endPointMapping(target)
        
        let urlRequest: URLRequest
        switch endPoint.urlRequest() {
        case .success(let request):
            urlRequest = request
        case .failure(let error):
            print(error)
            completion(.failure(error))
            return
        }
        print(endPoint.url)
        print(endPoint.method)
        print("HTTPBody : \(try? JSONSerialization.jsonObject(with: urlRequest.httpBody ?? Data(), options: []))")
        
        let completionHandler: RequestCompletion = { ( data, response, error) in
            let result = Response.convertToResponse(response: response, request: urlRequest, data: data, error: error)
            
            switch result {
            case .success(let response):
                print("mapJsonObject \(response.mapJsonObject())")
                print("mapJsonArr \(response.mapJsonArr())")
            case .failure(let error):
                print("response fail with : \(error)")
            }
            
            if let callBackQueue = callBackQueue {
                callBackQueue.async {
                    completion(result)
                }
            } else {
                completion(result)
            }
        }
        
        let task = session.dataTask(with: urlRequest, completionHandler: completionHandler)
        task.resume()
    }
    
}
