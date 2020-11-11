//
//  UserProvider.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/11.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

struct TokenReponse: Decodable {
    let accessToken: String
    let user: UserInfo
}

struct UserInfo: Decodable {
    let id: Int
    let userName: String
    let imageURL: String
}

struct TokenRequest: Encodable {
    let type: String
    let code: String
}

protocol UserProvidable: AnyObject {
    
}
