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
    @IBOutlet weak var milestoneBadge: BadgeLabelView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    private var labelBadgeCells = [LabelItemViewModel]()
    
    private lazy var checkBoxGuideWidthConstraint = checkBoxGuideView.widthAnchor.constraint(equalToConstant: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellHorizontalScrollView.delegate = self
        cellHorizontalScrollView.decelerationRate = .init(rawValue: 0.99999)
        checkBoxGuideWidthConstraint.isActive = true
        checkBoxGuideView.isHidden = false
        
        milestoneBadge.setBorder(width: 1, color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        milestoneBadge.cornerRadiusRatio = 0.5
        milestoneBadge.setPadding(top: 5, left: 5, bottom: 5, right: 5)
        
        labelCollectionView.dataSource = self
        
        let layout = LeftAlignedBadgeFlowLayout()
        layout.leftSpacing = 10
        layout.estimatedItemSize = CGSize(width: bounds.width/3, height: 30)
        layout.minimumLineSpacing = 10
        labelCollectionView.setCollectionViewLayout(layout, animated: false)
        
        labelCollectionView.registerCell(type: LabelBadgeCellView.self)
        NSLayoutConstraint.activate([
            cellHorizontalScrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height + labelCollectionView.collectionViewLayout.collectionViewContentSize.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }

    func configure(issueItemViewModel: IssueItemViewModel) {
        
        titleLabel.text = issueItemViewModel.title
        setMilestone(title: issueItemViewModel.milestoneTitle)
        setLabels(labelViewModels: issueItemViewModel.labelItemViewModels)
        
        issueItemViewModel.didMilestoneChanged = { [weak self] milestone in
                self?.setMilestone(title: milestone)
        }
        
        issueItemViewModel.didLabelsChanged = { [weak self] (labelViewModels) in
            self?.setLabels(labelViewModels: labelViewModels)
        }
        
    }
    
    private func setMilestone(title: String) {
        if title.isEmpty {
            milestoneBadge.isHidden = true
        } else {
            milestoneBadge.isHidden = false
            milestoneBadge.text = title
        }
    }
    
    private func setLabels(labelViewModels: [LabelItemViewModel]) {
        self.labelBadgeCells.removeAll()
        self.labelBadgeCells = labelViewModels
        self.labelCollectionView.reloadData()
    }
    
    func resetScrollOffset() {
        cellHorizontalScrollView.contentOffset = CGPoint.zero
    }
    
    func setCheck(_ check: Bool) {
        checkBoxButton.setImage(check ? Constant.checkedImage : Constant.uncheckedImage, for: .normal)
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
        
        checkBoxGuideWidthConstraint.constant = show ? mainContentGuideView.bounds.width * 0.1 : 0
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

// MARK: - UICollectionViewDataSource Implementation

extension IssueCellView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelBadgeCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: LabelBadgeCellView = collectionView.dequeueCell(at: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(labelViewModel: labelBadgeCells[indexPath.row])
        return cell
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

// MARK: - Constant

extension IssueCellView {
    enum Constant {
        static let uncheckedImage = UIImage(systemName: "circle")
        static let checkedImage = UIImage(systemName: "checkmark.circle.fill")
    }
}
