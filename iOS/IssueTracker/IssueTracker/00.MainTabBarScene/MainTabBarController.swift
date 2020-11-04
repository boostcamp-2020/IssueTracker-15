//
//  MainTabBarController.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit
import NetworkFramework

class MainTabBarController: UITabBarController {
    
    private var dataLoader: DataLoadable?
    private var labelProvider: LabelProvidable?
    private var milestoneProvider: MilestoneProvidable?
    
    func setupSubViewControllers(with dataLoader: DataLoadable) {
        
        let labelProvider = LabelProvider(dataLoader: dataLoader)
        let milestoneProvider = MilestoneProvider(dataLoader: dataLoader)
        
        let commonAppearance = UINavigationBarAppearance()
        commonAppearance.backgroundColor = .white
        commonAppearance.shadowColor = .gray
        // controllers[0] = UINavigationController -> root: IssueListViewController
        if let navigationController = self.viewControllers?[safe: 0] as? UINavigationController,
            let issueListViewController = navigationController.topViewController as? IssueListViewController {
            navigationController.navigationBar.scrollEdgeAppearance = commonAppearance
        }
        // controllers[1] = LabelListViewController
        if let navigationController = self.viewControllers?[safe: 1] as? UINavigationController,
            let labelListViewController = navigationController.topViewController as? LabelListViewController {
            navigationController.navigationBar.scrollEdgeAppearance = commonAppearance
            
            labelListViewController.labelListViewModel = LabelListViewModel(with: labelProvider)
        }
        // controllers[2] = MilestoneListViewConroller
        if let navigationController = self.viewControllers?[safe: 2] as? UINavigationController,
            let milestoneListViewController = navigationController.topViewController as? MilestoneListViewController {
            navigationController.navigationBar.scrollEdgeAppearance = commonAppearance
            milestoneListViewController.milestoneListViewModel = MilestoneListViewModel(with: milestoneProvider)
        }
        // controllers[3] = SettingViewController
        
        self.dataLoader = dataLoader
        self.labelProvider = labelProvider
        self.milestoneProvider = milestoneProvider
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
