//
//  UserProvider.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/11.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import Foundation
import NetworkFramework

struct TokenResponse: Decodable {
    let accessToken: String
    let user: User
}

struct TokenRequest: Encodable {
    let type: String
    let code: String
}

protocol UserProvidable: AnyObject {
    func requestAccessToken(code: String, completion: @escaping (LoginResult) -> Void )
    
    var users: [Int: User] { get set }
}

enum LoginResult {
    case success
    case failure
}

class UserProvider: UserProvidable {
    
    var token: String?
    var currentUser: User?
    
    var users = [Int: User]()
    
    private weak var dataLoader: DataLoadable?
    
    init(dataLoader: DataLoadable) {
        self.dataLoader = dataLoader
    }
    
    func requestAccessToken(code: String, completion: @escaping (LoginResult) -> Void ) {
        let request = TokenRequest(type: "iOS", code: code)
        dataLoader?.request(AuthService.server(request), callBackQueue: .main, completion: { [weak self] (response) in
            switch response {
            case .failure:
                completion(.failure)
            case .success(let response):
                guard let `self` = self,
                    let tokenResult = response.mapEncodable(TokenResponse.self) else {
                    completion(.failure)
                    return
                }
                self.currentUser = tokenResult.user
                self.token = tokenResult.accessToken
                completion(.success)
            }
        })
    }
    
}
