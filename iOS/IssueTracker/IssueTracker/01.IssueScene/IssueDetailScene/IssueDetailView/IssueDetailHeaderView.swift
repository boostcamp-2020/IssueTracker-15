//
//  IssueDetailHeaderView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

enum IssueBadgeColor: String {
    case open = "OpenIssueBackgroundColor"
    case closed = "ClosedIssueBackgroundColor"
}

class IssueDetailHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var issueAuthor: UILabel!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var issueBadge: UIButton!
    
    func configure(with headerViewModel: IssueDetailHeaderViewModel) {
        self.issueAuthor.text = headerViewModel.author.userName
        self.issueTitle.text = headerViewModel.title
        self.issueNumber.text = "#" + String(headerViewModel.id)
        configureIssueBadge(isOpened: headerViewModel.isOpened)
        headerViewModel.needImage { [weak self] (data) in
            self?.setProfileImage(data: data)
        }
    }
    
    private func configureIssueBadge(isOpened: Bool) {
        var badgeColor: UIColor
        var badgeText: String
        badgeColor = isOpened ? UIColor(named: IssueBadgeColor.open.rawValue) ?? UIColor.green : UIColor(named: IssueBadgeColor.closed.rawValue) ?? UIColor.red
        badgeText = isOpened ? "Open" : "Closed"
        
        issueBadge.convertToIssueBadge(text: badgeText, backgroundColor: badgeColor)
        issueBadge.contentEdgeInsets = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
    }
    
    private func setProfileImage(data: Data?) {
        guard let data = data else { return }
        profilePicture.image = UIImage(data: data)
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

extension UIButton {
    
    func convertToIssueBadge(text: String, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.setTitle(text, for: .normal)
    }
    
}
