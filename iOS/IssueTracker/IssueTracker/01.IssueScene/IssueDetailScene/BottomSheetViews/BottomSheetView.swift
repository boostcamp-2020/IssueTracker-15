//
//  AddCommentView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

protocol BottomSheetViewDelegate: AnyObject {
    func addCommentButtonTapped()
    func upButtonTapped()
    func downButtonTapped()
    func categoryHeaderTapped(type: DetailSelectionType)
}

class BottomSheetView: UIView {
    
    weak var delegate: BottomSheetViewDelegate?
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var labelsCollectionViewCell: BottomSheetLabelCollectionView?
    
    private weak var issueDetailViewModel: IssueDetailViewModelProtocol?
    
    var fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height
            - (addCommentButton.frame.maxY + (self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0))
    }
    
    func configure(issueDetailViewModel: IssueDetailViewModelProtocol?) {
        self.issueDetailViewModel = issueDetailViewModel
        self.issueDetailViewModel?.didMilestoneChanged = reloadData
        self.issueDetailViewModel?.didLabelChanged = reloadData
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureGesture()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureGesture() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        self.addGestureRecognizer(gesture)
    }
    
}

// MARK: - Action
extension BottomSheetView {
    func reloadData() {
        tableView.reloadData()
    }
    
    @IBAction func addCommentButtonTapped(_ sender: Any) {
        delegate?.addCommentButtonTapped()
    }
    
    @IBAction func upButtonTapped(_ sender: Any) {
        delegate?.upButtonTapped()
    }
    
    @IBAction func downButtonTapped(_ sender: Any) {
        delegate?.downButtonTapped()
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let velocity = recognizer.velocity(in: self)
        let y = self.frame.minY
        
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.frame = CGRect(x: 0, y: y + translation.y, width: self.frame.width, height: self.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self)
        }
        
        if recognizer.state == .ended {
            var duration = velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if velocity.y >= 0 {
                    self.frame = CGRect(x: 0, y: self.partialView, width: self.frame.width, height: self.frame.height)
                } else {
                    self.frame = CGRect(x: 0, y: self.fullView, width: self.frame.width, height: self.frame.height)
                }
            }, completion: nil)
        }
        
    }
    
}

// MARK: - UITableViewDelegate Implementation

extension BottomSheetView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = BottomSheetHeaderView.createView()
        headerView?.configure(type: TableViewConstant.headerTitles[section])
        headerView?.onHeaderViewTapped = { [weak self] headerType in
            self?.delegate?.categoryHeaderTapped(type: headerType)
        }
        return headerView
    }
    
}

// MARK: - UITableViewDataSource Implementation

extension BottomSheetView: UITableViewDataSource {
    
    enum TableViewConstant {
        static let headerTitles = [DetailSelectionType.assignee, DetailSelectionType.label, DetailSelectionType.milestone]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return issueDetailViewModel?.assignees.count ?? 0
        case 1:
            let num = (issueDetailViewModel?.labels ?? []).isEmpty ? 0 : 1
            return num
        case 2:
            return (issueDetailViewModel?.milestone != nil) ? 1 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let userComponentView = UserInfoComponentView.createView(),
                let userViewModel = issueDetailViewModel?.assignees[safe: indexPath.row]
                else { break }
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.addSubview(userComponentView)
            NSLayoutConstraint.activate([
                userComponentView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                userComponentView.topAnchor.constraint(equalTo: cell.topAnchor),
                userComponentView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
            ])
            userComponentView.configure(viewModel: CellComponentViewModel(title: userViewModel.userName, element: userViewModel.imageURL ?? ""))
            return cell
        case 1:
            guard let labelViewModels = issueDetailViewModel?.labels else { break }
            
            let cell: BottomSheetLabelCollectionView
            if let labelsCollectionViewCell = self.labelsCollectionViewCell {
                cell = labelsCollectionViewCell
            } else if let labelsCollectionViewCell = BottomSheetLabelCollectionView.createView() {
                cell = labelsCollectionViewCell
                self.labelsCollectionViewCell = cell
            } else {
                break
            }
            
            cell.configure(labelItemViewModels: labelViewModels)
            return cell
        case 2:
            guard let cell = BottomSheetMilestoneView.createView(),
                let milestoneViewModel = issueDetailViewModel?.milestone
                else { break }
            cell.configure(milestoneViewModel: milestoneViewModel)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UIScreen.main.bounds.height / 17
        case 1:
            labelsCollectionViewCell?.layoutIfNeeded()
            return labelsCollectionViewCell?.labelCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0
        case 2:
            return UIScreen.main.bounds.height / 15
        default:
            return 0
        }
    }
}

// MARK: - loadNIB extension
extension BottomSheetView {
    static let identifier = "BottomSheetView"
    
    static func createView() -> BottomSheetView? {
        return Bundle.main.loadNibNamed(BottomSheetView.identifier, owner: self, options: nil)?.last as? BottomSheetView
    }
}
