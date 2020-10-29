//
//  MilestoneHeaderView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/29.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class MilestoneHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!

    func configure(title: String) {
        headerLabel.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.font = headerLabel.font.withSize(headerLabel.bounds.height)
    }
}
