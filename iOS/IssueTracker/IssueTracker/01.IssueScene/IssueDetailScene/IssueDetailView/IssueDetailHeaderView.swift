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
    
    @IBOutlet weak var issueAuthor: UILabel!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var issueBadge: UILabel!
    
    func configure(with issueDetailViewModel: IssueDetailViewModel) {
        self.issueAuthor.text = issueDetailViewModel.author
        self.issueTitle.text = issueDetailViewModel.title
        self.issueNumber.text = "#" + String(issueDetailViewModel.issueNumber)
        configureIssueBadge(text: issueDetailViewModel.badge, isOpened: issueDetailViewModel.isOpened)
    }
    
    private func configureIssueBadge(text: String, isOpened: Bool) {
        var badgeColor: UIColor
        badgeColor = isOpened ? UIColor(named: IssueBadgeColor.open.rawValue) ?? UIColor.green : UIColor(named: IssueBadgeColor.closed.rawValue) ?? UIColor.red
        
        issueBadge.convertToIssueBadge(text: text, textColor: .white, backgroundColor: badgeColor)
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

extension UILabel {
    
    func convertToIssueBadge(text: String, textColor: UIColor, backgroundColor: UIColor) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        
        let textAttachment = NSTextAttachment()
        let badgeImage = UIImage(systemName: "exclamationmark.circle")?.withTintColor(textColor)
        textAttachment.image = badgeImage
        let attributedStringWithImage = NSAttributedString(attachment: textAttachment)
        
        let fullAttributedString = NSMutableAttributedString(string: "")
        fullAttributedString.append(attributedStringWithImage)
        fullAttributedString.append(NSMutableAttributedString(string: text))
        
        self.attributedText = fullAttributedString
    }
    
}
