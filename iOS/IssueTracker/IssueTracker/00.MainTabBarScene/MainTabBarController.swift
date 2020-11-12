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
    
    private weak var dataLoader: DataLoadable?
    
    private var labelProvider: LabelProvidable
    private var milestoneProvider: MilestoneProvidable
    private var issueProvider: IssueProvidable
    
    init?(coder: NSCoder, dataLoader: DataLoadable, userProvider: UserProvidable) {
        self.dataLoader = dataLoader
        self.issueProvider = IssueProvider(dataLoader: dataLoader, userProvider: userProvider)
        self.labelProvider = LabelProvider(dataLoader: dataLoader, userProvider: userProvider)
        self.milestoneProvider = MilestoneProvider(dataLoader: dataLoader, userProvider: userProvider)
        
        super.init(coder: coder)
        
        setupSubViewControllers()
    }
    
    required init?(coder: NSCoder) {
        let dataLoader = DataLoader(session: URLSession.shared)
        let userProvider = UserProvider(dataLoader: dataLoader)
        self.issueProvider = IssueProvider(dataLoader: dataLoader, userProvider: userProvider)
        self.labelProvider = LabelProvider(dataLoader: dataLoader, userProvider: userProvider)
        self.milestoneProvider = MilestoneProvider(dataLoader: dataLoader, userProvider: userProvider)
        self.dataLoader = dataLoader
        
        super.init(coder: coder)
    }
    
    func setupSubViewControllers() {
        
        let commonAppearance = UINavigationBarAppearance()
        commonAppearance.backgroundColor = .white
        commonAppearance.shadowColor = .gray
        
        // controllers[0] = UINavigationController -> root: IssueListViewController
        if let navigationController = self.viewControllers?[safe: 0] as? UINavigationController,
            let issueListViewController = navigationController.topViewController as? IssueListViewController {
            navigationController.navigationBar.scrollEdgeAppearance = commonAppearance
            
            let issueListViewModel = IssueListViewModel(labelProvider: labelProvider,
                                                        milestoneProvider: milestoneProvider,
                                                        issueProvider: issueProvider)
            
            issueListViewController.issueListViewModel = issueListViewModel
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MainTabBarController {
    static let storyBoardName = "Main"
    
    static func createViewController(dataLoader: DataLoadable, userProvider: UserProvidable) -> UIViewController? {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        
        let mainTabBarController = storyBoard.instantiateInitialViewController { (coder) -> UIViewController? in
            return MainTabBarController(coder: coder, dataLoader: dataLoader, userProvider: userProvider)
        }
        
        return mainTabBarController
    }
}
