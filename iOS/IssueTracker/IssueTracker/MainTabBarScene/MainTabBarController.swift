//
//  MainTabBarController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupDependencies()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDependencies()
    }
    
    func setupDependencies() {
        guard let labelListViewController = self.viewControllers?.first as? LabelListViewController else { return }
        labelListViewController.labelListViewModel = LabelListViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
