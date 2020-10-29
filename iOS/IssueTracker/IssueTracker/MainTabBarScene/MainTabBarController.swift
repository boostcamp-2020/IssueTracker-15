//
//  MainTabBarController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    func setupDependencies() {
        // controllers[0] = UINavigationController -> root: IssueListViewController
        // controllers[1] = LabelListViewController
        if let labelListViewController = self.viewControllers?[safe: 1] as? LabelListViewController {
            labelListViewController.labelListViewModel = LabelListViewModel()
        }
        // controllers[2] = MilestoneListViewConroller
        if let milestoneListViewController = self.viewControllers?[safe: 2] as? MilestoneListViewController {
            milestoneListViewController.milestoneListViewModel = MilestoneListViewModel()
        }
        // controllers[3] = SettingViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
