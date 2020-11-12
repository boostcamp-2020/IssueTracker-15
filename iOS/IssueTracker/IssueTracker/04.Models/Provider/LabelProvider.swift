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
    
    var labels: [Int: Label] { get }
    
    func addLabel(title: String, description: String, color: String, completion:  @escaping (Label?) -> Void )
    func editLabel(id: Int, title: String, description: String, color: String, completion:  @escaping (Label?) -> Void)
    //func deleteLabel(id: Int, completion: (Bool)->Void)
    func fetchLabels(completion: @escaping ([Label]?) -> Void)
    
    func getLabels(of ids: [Int], completion: @escaping ([Label]) -> Void)
    func getLabel(at id: Int, completion: @escaping (Label?) -> Void)
}

class LabelProvider: LabelProvidable {
    
    private(set) var labels = [Int: Label]()
    private weak var dataLoader: DataLoadable?
    private weak var userProvider: UserProvidable?
    
    private var onFetching = false
    private var fetchingCompletionHandlers = [Int: ([Label]?)->Void]()
    
    init(dataLoader: DataLoadable, userProvider: UserProvidable) {
        self.dataLoader = dataLoader
        self.userProvider = userProvider
    }
    
    func getLabels(of ids: [Int], completion: @escaping ([Label]) -> Void) {
        let founded = ids.compactMap { self.labels[$0] }
        if founded.count == ids.count {
            completion(founded)
            return
        }
        
        fetchLabels { [weak self] _ in
            let founded = ids.compactMap { self?.labels[$0] }
            completion(founded)
        }
    }
    
    func getLabel(at id: Int, completion: @escaping (Label?) -> Void) {
        if labels.contains(where: {$0.key == id }) {
            completion(labels[id])
            return
        }
        
        // TODO : fetch 함수 분리하기
        fetchLabels { [weak self] _ in
            if let label = self?.labels[id] {
                completion(label)
                return
            }
            completion(nil)
        }
    }
    
    func addLabel(title: String, description: String, color: String, completion: @escaping (Label?) -> Void) {
        dataLoader?.request(LabelService.createLabel(title, description, color), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                guard let `self` = self,
                    let label = response.mapEncodable(Label.self)
                    else {
                        completion(nil)
                        return
                }
                self.labels[label.id] = label
                completion(label)
            }
        })
    }
    
    func editLabel(id: Int, title: String, description: String, color: String, completion: @escaping (Label?) -> Void) {
        dataLoader?.request(LabelService.editLabel(id, title, description, color), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success:
                let label = Label(id: id, title: title, description: description, hexColor: color)
                self?.labels[id] = label
                completion(label)
            }
        })
    }
    
    func fetchLabels(completion: @escaping ([Label]?) -> Void) {
        if onFetching {
            fetchingCompletionHandlers[fetchingCompletionHandlers.count] = completion
            return
        }
        
        onFetching = true
        fetchingCompletionHandlers[fetchingCompletionHandlers.count] = completion
        
        dataLoader?.request(LabelService.fetchAll, callBackQueue: .main, completion: { (response) in
            switch response {
            case .failure:
                completion(nil)
            case .success(let response):
                if let labels = response.mapEncodable([Label].self) {
                    self.labels = labels.reduce(into: [:]) { $0[$1.id] = $1 }
                    self.fetchingCompletionHandlers.forEach {
                        $0.value(labels)
                    }
                }
            }
            
            self.fetchingCompletionHandlers.removeAll()
            self.onFetching = false
        })
    }
    
}
