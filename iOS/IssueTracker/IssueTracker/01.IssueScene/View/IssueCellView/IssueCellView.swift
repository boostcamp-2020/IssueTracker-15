//
//  IssueCellWithScroll.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/01.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueCellView: UICollectionViewCell {
    
    @IBOutlet weak var cellHorizontalScrollView: UIScrollView!
    
    @IBOutlet weak var checkBoxGuideView: UIView!
    @IBOutlet weak var mainContentGuideView: UIView!
    @IBOutlet weak var closeBoxGuideView: UIView!
    @IBOutlet weak var deleteBoxGuideView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var milestoneBadge: BadgeLabelView!
    @IBOutlet weak var labelBadge: BadgeLabelView!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    private lazy var checkBoxGuideWidthConstraint = checkBoxGuideView.widthAnchor.constraint(equalToConstant: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellHorizontalScrollView.delegate = self
        cellHorizontalScrollView.decelerationRate = .init(rawValue: 0.99999)
        checkBoxGuideWidthConstraint.isActive = true
        checkBoxGuideView.isHidden = false
        
        descriptionLabel.numberOfLines = 2
        
        milestoneBadge.setBorder(width: 1, color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        milestoneBadge.cornerRadiusRatio = 0.5
        milestoneBadge.setPadding(top: 5, left: 5, bottom: 5, right: 5)
        
        labelBadge.cornerRadiusRatio = 0.5
        labelBadge.setPadding(top: 3, left: 5, bottom: 3, right: 5)
    }
    
    func configure(issueItemViewModel: IssueItemViewModel) {
        
        titleLabel.text = issueItemViewModel.title
        descriptionLabel.text = issueItemViewModel.description
        
        issueItemViewModel.didMilestoneChanged = { [weak self] milestone in
            DispatchQueue.main.async {
                self?.milestoneBadge.text = milestone
            }
        }
        
        issueItemViewModel.didLabelChanged = { [weak self] (text, colorCode) in
            DispatchQueue.main.async {
                self?.labelBadge.text = text
                self?.labelBadge.setBackgroundColor(colorCode.color)
            }
        }
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.autoResizeFontWithHeight()
        descriptionLabel.autoResizeFontWithHeight()
    }
    
}

// MARK: - Action
extension IssueCellView {
    
    @IBAction func checkBoxButtonTapped(_ sender: Any) {
        checkBoxButton.isSelected.toggle()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
    }
    
    func showCheckBox(show: Bool, animation: Bool) {
        cellHorizontalScrollView.contentOffset = CGPoint.zero
        cellHorizontalScrollView.isScrollEnabled = !show
        checkBoxGuideWidthConstraint.constant = show ? checkBoxGuideView.bounds.height * 0.5 : 0
        if animation {
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
        }
    }
    
}

// MARK: - UIScrollViewDelegate Implementation
extension IssueCellView: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = pagingTargetOffset(contentOffset: scrollView.contentOffset)
    }
    
    private func pagingTargetOffset(contentOffset: CGPoint) -> CGPoint {
        
        if contentOffset.x >= 0 && contentOffset.x < closeBoxGuideView.bounds.width / 2 {
            return CGPoint.zero
        }
        
        if contentOffset.x >= closeBoxGuideView.bounds.width / 2 &&
            contentOffset.x < closeBoxGuideView.bounds.width + deleteBoxGuideView.bounds.width / 2 {
            return CGPoint(x: closeBoxGuideView.bounds.width, y: 0)
        }
        
        return CGPoint(x: closeBoxGuideView.bounds.width + deleteBoxGuideView.bounds.width, y: 0)
    }
    
}

// MARK: - UICollectionViewRegisterable Implementation
extension IssueCellView: UICollectionViewRegisterable {
    static var cellIdentifier: String {
        "IssueCellView"
    }
    
    static var cellNib: UINib {
        UINib(nibName: cellIdentifier, bundle: nil)
    }
}
