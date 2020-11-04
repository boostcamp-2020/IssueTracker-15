//
//  IabelProvider.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/03.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol LabelProvidable: AnyObject {
    func addLabel(title: String, description: String, color: String, completion:  @escaping (Label?) -> Void )
    func editLabel(id: Int, title: String, description: String, color: String, completion:  @escaping (Label?) -> Void)
    //func deleteLabel(id: Int, completion: (Bool)->Void)
    func fetchLabels(completion: @escaping ([Label]?) -> Void)
}

class LabelProvider: LabelProvidable {
    
    //private(set) var labels = [Label]()
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
    }
    
    func addLabel(title: String, description: String, color: String, completion: @escaping (Label?) -> Void) {
        
        let endPoint = LabelEndPoint(requestType: .create)
        endPoint.httpBody = JSONEncoder.encode(data: Label(title: title, description: description, hexColor: color))
        dataLoader?.request(Label.self, endpoint: endPoint, completion: { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        })

    }
    
    func editLabel(id: Int, title: String, description: String, color: String, completion: @escaping (Label?) -> Void) {
        
        let endPoint = LabelEndPoint(requestType: .edit, parameter: String(id))
        endPoint.httpBody = JSONEncoder.encode(data: Label(id: id, title: title, description: description, hexColor: color))
        dataLoader?.request(Label.self, endpoint: endPoint, completion: { (result) in
            switch result {
            case .success:
                let label = Label(id: id, title: title, description: description, hexColor: color)
                completion(label)
            case .failure:
                completion(nil)
            }
        })

    }
    
    func fetchLabels(completion: @escaping ([Label]?) -> Void) {
        
        let labelFetchEndPoint = LabelEndPoint(requestType: .fetch)
        dataLoader?.request([Label].self, endpoint: labelFetchEndPoint, completion: { (result) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        })
        
    }
    
}
