//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/11.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit
import NetworkFramework

class LoginViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(nibName: String, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func githubSigninButtonTapped(_ sender: Any) {
        // login
        if let url = try? URL(target: AuthService.github), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension LoginViewController {
    static let nibName = "LoginViewController"
    
    static func createViewController() -> LoginViewController {
        let vc = LoginViewController(nibName: nibName, bundle: Bundle.main)
        return vc
    }
}
