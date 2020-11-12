//
//  IssueDetailHeaderViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct IssueDetailHeaderViewModel: ImageLoadable {
    
    let id: Int
    let title: String
    let author: UserViewModel
    let isOpened: Bool
    
    init(id: Int, title: String, author: UserViewModel, isOpened: Bool) {
        self.id = id
        self.title = title
        self.author = author
        self.isOpened = isOpened
    }
    
    func needImage(completion: @escaping (Data?) -> Void) {
        author.needImage(completion: completion)
    }
    
}
