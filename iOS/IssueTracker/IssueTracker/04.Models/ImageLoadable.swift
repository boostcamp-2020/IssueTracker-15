//
//  ImageLoadable.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol ImageLoadable {
    func needImage(completion: @escaping (Data?) -> Void )
    func loadImage(url: String, completion: @escaping (Data?) -> Void )
}

extension ImageLoadable {
    func loadImage(url: String, completion: @escaping (Data?) -> Void ) {
        ImageLoader.shared.loadImage(from: url, callBackQueue: .main) { (result) in
            switch result {
            case .failure, .success(.none):
                completion(nil)
            case .success(.some(let data)):
                completion(data)
            }
        }
    }
}
