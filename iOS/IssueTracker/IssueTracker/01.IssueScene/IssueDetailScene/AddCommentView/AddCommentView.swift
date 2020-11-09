//
//  AddCommentView.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

protocol AddCommentDelegate: AnyObject {
    func addCommentButtonTapped()
    func upButtonTapped()
    func downButtonTapped()
}

class AddCommentView: UIView {
    weak var addCommentDelegate: AddCommentDelegate?
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var labelsCollectionViewCell: AddCommentLabelCollectionView?
    
    var fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - (addCommentButton.frame.maxY + (self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0))
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
    
    @IBAction func addCommentButtonTapped(_ sender: Any) {
        // delegate 발동
        addCommentDelegate?.addCommentButtonTapped()
    }
    
}

// MARK: - Action
extension AddCommentView {
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

    @IBAction func upButtonTapped(_ sender: Any) {
        addCommentDelegate?.upButtonTapped()
    }

    @IBAction func downButtonTapped(_ sender: Any) {
        addCommentDelegate?.downButtonTapped()
    }
}

// MARK: - UITableViewDelegate Implementation

extension AddCommentView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource Implementation

extension AddCommentView: UITableViewDataSource {

    enum TableViewConstant {
        static let headerTitles = ["담당자", "레이블", "마일스톤"]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let userComponentView = UserInfoComponentView.createView() else { break }
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.addSubview(userComponentView)
            NSLayoutConstraint.activate([
                userComponentView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                userComponentView.topAnchor.constraint(equalTo: cell.topAnchor),
                userComponentView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
            ])
            userComponentView.configure(viewModel: CellComponentViewModel(title: "김신우", element: "dkdkdkdkdk"))
            return cell
        case 1:
            guard let cell = AddCommentLabelCollectionView.createView() else { break }
            cell.configure(labelItemViewModels: [
                LabelItemViewModel(label: Label(title: "Inhencement", description: "", hexColor: "#FEF2C0")),
                LabelItemViewModel(label: Label(title: "Feature", description: "", hexColor: "#FBCA04")),
                LabelItemViewModel(label: Label(title: "Merge_Dev-iOS", description: "", hexColor: "#0075CA")),
                LabelItemViewModel(label: Label(title: "Merge_Dev-Web", description: "", hexColor: "#F7F9AC")),
                LabelItemViewModel(label: Label(title: "Merge_Feature", description: "", hexColor: "#D3F49F")),
                LabelItemViewModel(label: Label(title: "Release", description: "", hexColor: "#FBCA04"))
            ])
            labelsCollectionViewCell = cell
            return cell
        case 2:
            guard let cell = AddCommentMilestoneCellView.createView() else { break }
            cell.configure(milestoneViewModel: MilestoneItemViewModel(milestone: Milestone(id: 0, title: "마일스톤1", description: "", dueDate: "2020-11-04T00:00:00.000Z", openIssuesLength: "9", closeIssueLength: "2"), from: .fromServer))
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = AddCommentHeaderView.createView()
        headerView?.configure(title: TableViewConstant.headerTitles[section])
        return headerView
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
extension AddCommentView {
    static let identifier = "AddCommentView"
    static func createView() -> AddCommentView? {
        return Bundle.main.loadNibNamed(AddCommentView.identifier, owner: self, options: nil)?.last as? AddCommentView
    }
}
