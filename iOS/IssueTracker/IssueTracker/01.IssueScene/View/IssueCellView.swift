//
//  IssueCellView.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/01.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueCellView: UICollectionViewCell {
    
    @IBOutlet weak var checkBoxView: UIView!
    @IBOutlet weak var mainCellView: UIView!
    @IBOutlet weak var closeGuideView: UIView!
    @IBOutlet weak var deleteGuideView: UIView!
    @IBOutlet weak var closeLabe: UILabel!
    @IBOutlet weak var deleteLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var milestoneBadge: BadgeLabelView!
    @IBOutlet weak var labelBadge: BadgeLabelView!
    
    private var guideWidthLimit: CGFloat = 0
    private var closeGuideStartingConstant: CGFloat = 0
    private var deleteGuideStartingConstant: CGFloat = 0
    private lazy var closeGuideWidthConstraint = closeGuideView.widthAnchor.constraint(equalToConstant: 0)
    private lazy var deleteGuideWidthConstraint = deleteGuideView.widthAnchor.constraint(equalToConstant: 0)
    private lazy var checkBoxWidthConstraint = checkBoxView.widthAnchor.constraint(equalToConstant: 0)
    
    var showSelectBox : Bool = false {
        didSet {
            if showSelectBox {
                showSelectButton()
            } else {
                hideSelectButton()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        closeGuideWidthConstraint.isActive = true
        deleteGuideWidthConstraint.isActive = true
        checkBoxWidthConstraint.isActive = true
        guideWidthLimit = bounds.height
    }
    
    func configure() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        panGesture.minimumNumberOfTouches = 1
        addGestureRecognizer(panGesture)
    }
    
}

// MARK: - Actions
extension IssueCellView {
    
    func showSelectButton() {
        checkBoxWidthConstraint.constant = guideWidthLimit / 2
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    func hideSelectButton() {
        checkBoxWidthConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func panAction(gesture: UIGestureRecognizer) {
        guard let panGesture = gesture as? UIPanGestureRecognizer else { return }
        
        switch panGesture.state {
        case .ended:
            onPanGestureEnded()
        case .began:
            closeGuideStartingConstant = closeGuideWidthConstraint.constant
            deleteGuideStartingConstant = deleteGuideWidthConstraint.constant
        case .changed:
            let translation = panGesture.translation(in: self)
            if translation.x < 0 {
                onLeftSwipe(value: -translation.x)
            } else {
                onRightSwipe(value: translation.x)
            }
        default:
            return
        }
    }
    
    private func onPanGestureEnded() {
        let limit = guideWidthLimit
        self.closeGuideWidthConstraint.constant = self.closeGuideWidthConstraint.constant > limit / 2 ? limit : 0
        self.deleteGuideWidthConstraint.constant = self.deleteGuideWidthConstraint.constant > limit / 2 ? limit : 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func onLeftSwipe(value: CGFloat) {
        let firstValue = (value + closeGuideStartingConstant)
            .clamp(min: closeGuideWidthConstraint.constant, max: guideWidthLimit)
        closeGuideWidthConstraint.constant = firstValue
        let secondeValue = (value + closeGuideStartingConstant - guideWidthLimit + deleteGuideStartingConstant)
            .clamp(min: deleteGuideWidthConstraint.constant, max: guideWidthLimit)
        deleteGuideWidthConstraint.constant = secondeValue
    }
    
    private func onRightSwipe(value: CGFloat) {
        let firstValue = (deleteGuideStartingConstant - value).clamp(min: 0, max: guideWidthLimit)
        deleteGuideWidthConstraint.constant = firstValue
        let secondValue = (closeGuideStartingConstant - (value - deleteGuideStartingConstant)).clamp(min: 0, max: guideWidthLimit)
        closeGuideWidthConstraint.constant = secondValue
    }
    
}

extension IssueCellView: UICollectionViewRegisterable {
    static var cellIdentifier: String {
        "IssueCellView"
    }
    
    static var cellNib: UINib {
        UINib(nibName: cellIdentifier, bundle: nil)
    }
}
