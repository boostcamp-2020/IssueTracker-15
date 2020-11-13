//
//  UserViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation

struct UserViewModel: ImageLoadable {
    
    let id: Int
    var userName: String
    var imageURL: String?

    init(user: User? = nil) {
        self.id = user?.id ?? -1
        self.userName = user?.userName ?? ""
        self.imageURL = user?.imageURL
    }

    func needImage(completion: @escaping (Data?) -> Void) {
        guard let url = imageURL, !url.isEmpty else { return }
        loadImage(url: url, completion: completion)
    }
    
}
