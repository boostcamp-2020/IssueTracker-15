//
//  ImageLoader.swift
//  NetworkFramework
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

public typealias ImageResult = Result<Data?, NetworkError>
public typealias ImageCompletion = (_ result: ImageResult) -> Void

public class ImageLoader {
    
    public static let shared: ImageLoader = ImageLoader()
    
    let imageCache = NSCache<NSString, NSData>()
    
    public func loadImage(from urlStr: String, callBackQueue: DispatchQueue?, completion: @escaping ImageCompletion) {
        if let cachedData = imageCache.object(forKey: NSString(string: urlStr)) {
            completion(.success(cachedData as Data))
            return
        }
        guard let url = URL(string: urlStr) else {
            self.completion(callBackQueue: callBackQueue) {
                completion(.failure(.urlMappingError("url이 올바르지 않습니다.")))
            }
            return
        }
        
        let taskCompletion: (Data?, URLResponse?, Error?) -> Void  = { data, response, error in
            
            guard let data = data, !data.isEmpty else {
                self.completion(callBackQueue: callBackQueue) {
                    completion(.failure(NetworkError.imageIsNil))
                }
                return
            }
            
            self.imageCache.setObject(data as NSData, forKey: NSString(string: urlStr))
            self.completion(callBackQueue: callBackQueue) {
                completion(.success(data))
            }
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: taskCompletion)
        
        task.resume()
        
    }
    
    func completion(callBackQueue: DispatchQueue?, work: @escaping () -> Void ) {
        if let queue = callBackQueue {
            queue.async {
                work()
            }
        } else {
            work()
        }
    }
}
