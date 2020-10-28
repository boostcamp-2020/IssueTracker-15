//
//  LabelHeaderView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/10/27.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LabelHeaderView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    var plusButtonTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.font = headerLabel.font.withSize(headerLabel.bounds.height)
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        plusButtonTapped?()
    }
    
}
