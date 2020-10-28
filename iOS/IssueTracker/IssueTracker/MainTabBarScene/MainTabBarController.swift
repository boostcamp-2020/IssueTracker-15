//
//  MainTabBarController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // TODO:- Dependency Injection
    func setupDependencies() {
        // controllers[1] = UINavigationController -> root: IssueListViewController
        // controllers[2] = LabelListViewController
        guard let labelListViewController = self.viewControllers?[1] as? LabelListViewController else { return }
        labelListViewController.labelListViewModel = LabelListViewModel()
        // controllers[3] = MilestoneListViewConroller
        // controllers[4] = SettingViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
