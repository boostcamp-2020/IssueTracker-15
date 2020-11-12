//
//  IssueDetailCellView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/04.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueDetailCellView: UICollectionViewCell {
       
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var createAt: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    func configure(with comment: CommentViewModel) {
        content.text = comment.content
        author.text = comment.userName
        createAt.text = comment.createAt
        setProfile(data: comment.data)
        comment.didDataChanged = { [weak self] data in
            self?.setProfile(data: data)
        }
    }
    
    func setProfile(data: Data?) {
        guard let data = data else { return }
        profilePicture.image = UIImage(data: data)
    }
}

extension IssueDetailCellView: UICollectionViewRegisterable {
    
    static var cellIdentifier: String {
        return "IssueDetailCellView"
    }
    
    static var cellNib: UINib {
        return UINib(nibName: "IssueDetailCellView", bundle: .main)
    }
    
}
