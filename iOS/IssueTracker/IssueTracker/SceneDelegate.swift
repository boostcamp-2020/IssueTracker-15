//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/26.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit
import NetworkFramework

struct FoodListResponse: Codable {
    var statusCode: Int
    var body: [StoreItem] = [StoreItem]()
}

struct StoreItem: Codable {
    var detail_hash: String
    var image: String
    var alt: String
    var delivery_type: [String]
    var title: String
    var description: String
    var n_price: String?
    var s_price: String
    var badge: [String]?
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil,
              let mainTabVC = window?.rootViewController as? MainTabBarController
        else { return }
        // TODO:- Network, Cache, AuthService 초기화 및 로그인 여부 검증 -> AppDelegate로??
        mainTabVC.setupSubViewControllers()
        
        let milestoneEndPoint = MilestoneEndPoint(requestType: .test, parameter: "main")
        let session = URLSession.init(configuration: .default, delegate: nil, delegateQueue: nil)
        let dataLoader = DataLoader<StoreItem>(session: session)
        dataLoader.reqeust(endpoint: milestoneEndPoint) { (response) in
            print(response!)
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
