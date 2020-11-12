//
//  CommentViewModel.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/12.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

class CommentViewModel: ImageLoadable {
    let content: String
    let createAt: String
    let userName: String
    let imageURL: String?
    
    init(comment: Comment) {
        content = comment.content
        createAt = comment.createAt
        userName = comment.author.userName
        imageURL = comment.author.imageURL
    }
    
    func needImage(completion: @escaping (Data?) -> Void ) {
        guard let url = imageURL, !url.isEmpty else { return }
        loadImage(url: url, completion: completion)
    }
}
