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
    
    var dataLoader: DataLoader?
    var userProvider: UserProvidable?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            let code = url.absoluteString.components(separatedBy: "code=").last ?? ""
            userProvider?.requestAccessToken(code: code, completion: { (result) in
                guard let window = self.window,
                    let dataLodaer = self.dataLoader,
                    let userProvider = self.userProvider
                else { return }
                switch result {
                case .success:
                    UIView.transition(with: window, duration: 0.5, options: .transitionCurlUp, animations: {
                        window.rootViewController = MainTabBarController.createViewController(dataLoader: dataLodaer, userProvider: userProvider)
                        window.makeKeyAndVisible()
                    }, completion: nil)
                case .failure:
                return
                }
                
            })
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        self.dataLoader = DataLoader(session: session)
        self.userProvider = UserProvider(dataLoader: dataLoader!)
        
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
