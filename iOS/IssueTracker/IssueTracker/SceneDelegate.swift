//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/26.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit
import NetworkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    // user provider
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            let code = url.absoluteString.components(separatedBy: "code=").last ?? ""
            print(code)
                // userProvider.requestAccessToken(with: code) { (token) in
//                guard let token = token else { return }
//                print(token)
            
                // transition 실행이 User provider의 token 요청의 completion으로
//                guard let window = window else { return }
//                UIView.transition(with: window, duration: 1, options: .transitionCurlUp, animations: {
//                    window.rootViewController = mainTabVC
//                    window.makeKeyAndVisible()
//                }, completion: nil)
//            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }
        // TODO:- Network, Cache, AuthService 초기화 및 로그인 여부 검증 -> AppDelegate로??
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let dataLoader = DataLoader(session: session)
        
        let mainTabVC = MainTabBarController.createViewController(dataLoader: dataLoader)
        let loginViewController = LoginViewController.createViewController()
        
        self.window?.rootViewController = loginViewController
        self.window?.makeKeyAndVisible()
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
