//
//  LabelListViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/28.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

protocol LabelListViewModelProtocol: AnyObject {
    var didFetch: (() -> Void)? { get set }
    func needFetchItems()
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel
    func numberOfItem() -> Int
    func addNewLabel(title: String, desc: String, hexColor: String)
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String)
}

class LabelListViewModel: LabelListViewModelProtocol {
    
    var didFetch: (() -> Void)?
    private var labels = [Label]()
    
    func editLabel(at indexPath: IndexPath, title: String, desc: String, hexColor: String) {
        labels[indexPath.row] = Label(title: title, description: desc, hexColor: hexColor)
        
        didFetch?()
    }
    
    func addNewLabel(title: String, desc: String, hexColor: String) {
        let newLabel: Label = Label(title: title, description: desc, hexColor: hexColor)
        labels.insert(newLabel, at: 0)
        
        didFetch?()
    }
    
    func needFetchItems() {
        // 네트워크 통신으로 fetch
        let labelFetchEndPoint = LabelEndPoint(requestType: .fetch)
        let session = URLSession.init(configuration: .default, delegate: nil, delegateQueue: nil)
        let dataLoader = DataLoader<[Label]>(session: session)
        dataLoader.reqeust(endpoint: labelFetchEndPoint) { [weak self] (response) in
            switch response {
            case .success(let data):
                guard let data = data else { return }
                self?.labels = data
                DispatchQueue.main.async {
                    self?.didFetch?()
                }
            case .failure(let error):
                switch error {
                case .decodingError(let message), .invalidURL(let message), .responseError(let message):
                    print(message)
                }
            }
        }
    }
    
    func cellForItemAt(path: IndexPath) -> LabelItemViewModel {
        return LabelItemViewModel(label: labels[path.row])
    }
    
    func numberOfItem() -> Int {
        labels.count
    }
    
}
