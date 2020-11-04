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
    
    func getLabel(at id: Int, completion: @escaping (Label?) -> Void)
}

class LabelProvider: LabelProvidable {
    
    // TODO: 같은 Fetch 요청이 여러번 들어왔을 겨우 completion을 배열에 넣어두었다 한 패칭에 Completion을 모두 처리해주는 방식으로!
    // 추상화 단계를 한단계 올릴지 생각해 볼것!
    private var onFetching = false
    // Key, Value(CompletionFunc) 로 관리하고 처리 됬을 경우 삭제해주기!
    // 효율적인 key 관리 기법 생각해보기!
    private var fetchingCompletionHandlers = [Int:([Label]?)->Void]()
    
    private(set) var labels = [Label]()
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
    }
    
    func getLabel(at id: Int, completion: @escaping (Label?) -> Void) {
        if let idx = labels.firstIndex(where: {$0.id == id}) {
            completion(labels[idx])
            return
        }
        
        // TODO : fetch 함수 분리하기
        fetchLabels { [weak self] _ in
            if let label = self?.labels.first(where: {$0.id == id}) {
                completion(label)
                return
            }
            completion(nil)
        }
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
        if(onFetching) {
            fetchingCompletionHandlers[fetchingCompletionHandlers.count] = completion
            return
        }
        
        onFetching = true
        fetchingCompletionHandlers[fetchingCompletionHandlers.count] = completion
        let labelFetchEndPoint = LabelEndPoint(requestType: .fetch)
        dataLoader?.request([Label].self, endpoint: labelFetchEndPoint, completion: { (result) in
            switch result {
            case .success(let data):
                if let data = data { self.labels = data }
                self.fetchingCompletionHandlers.forEach {
                    $0.value(data)
                }
            case .failure:
                completion(nil)
            }
            
            self.fetchingCompletionHandlers.removeAll()
            self.onFetching = false
        })
        
    }
    
}
