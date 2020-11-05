//
//  IssueDetailHeaderView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueDetailHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var issueAuthor: UILabel!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var issueBadge: UIButton!
    
    func configure(with issueDetailViewModel: IssueDetailViewModel) {
        self.issueAuthor.text = issueDetailViewModel.author
        self.issueTitle.text = issueDetailViewModel.title
        self.issueNumber.text = "#" + String(issueDetailViewModel.issueNumber)
        configureIssueBadge(text: issueDetailViewModel.badge, color: issueDetailViewModel.badgeColor)
    }
    
    private func configureIssueBadge(text: String, color: IssueBadgeColor) {
        var badgeColor: UIColor
        
        switch color {
        case .green:
            badgeColor = UIColor.green
        case .red:
            badgeColor = UIColor.red
        }
        
        issueBadge.setTitle(text, for: .normal)
        issueBadge.backgroundColor = badgeColor
    }
}

extension IssueDetailHeaderView: UICollectionViewHeaderRegisterable {
    static var headerIdentifier: String {
        return "IssueDetailHeaderView"
    }
    
    static var headerNib: UINib {
        return UINib(nibName: "IssueDetailHeaderView", bundle: .main)
    }
    
}
