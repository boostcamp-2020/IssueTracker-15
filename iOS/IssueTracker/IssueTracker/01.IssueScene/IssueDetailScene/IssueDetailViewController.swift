//
//  IssueDetailViewController-tmp.swift
//  IssueTracker
//
//  Created by sihyung you on 2020/11/05.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {
    static let identifier = "IssueDetailViewController"
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var addCommentView: AddCommentView?
    private var issueDetailViewModel: IssueDetailViewModelProtocol
    private var currentIssueId: Int = -1
    
    private var currentIndexPath: IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.minY)
        if let currentIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            return currentIndexPath
        } else {
            return IndexPath(item: -1, section: 0)
        }
    }
    
    init(issueDetailViewModel: IssueDetailViewModelProtocol) {
        self.issueDetailViewModel = issueDetailViewModel
        super.init(nibName: nil, bundle: nil)
        
        self.issueDetailViewModel.didFetch = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        issueDetailViewModel = IssueDetailViewModel(id: 1, issueProvider: nil, labelProvier: nil, milestoneProvider: nil)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarButtons()
        issueDetailViewModel.needFetchDetails()
        navigationItem.title = "이슈 상세"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureInitialLayout()
    }
    
    private func configureNavigationBarButtons() {
        configureEditButton()
    }
    
    private func configureEditButton() {
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    private func configureCollectionView() {
        setupCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerHeader(type: IssueDetailHeaderView.self)
        collectionView.registerCell(type: IssueDetailCellView.self)
    }
    
    private func configureInitialLayout() {
        guard addCommentView != nil else {
            configureCollectionView()
            configureBottomSheetView()
            addBottomSheetView()
            return
        }
    }
    
    private func configureBottomSheetView() {
        addCommentView = AddCommentView.createView()
        let height = view.frame.height
        let width  = view.frame.width
        self.addCommentView?.frame = CGRect(x: 0, y: self.view.frame.maxY * 0.85, width: width, height: height)
    }
    
    private func addBottomSheetView() {
        guard let addCommentView = addCommentView else { return }
        
        addCommentView.addCommentDelegate = self
        
        self.view.addSubview(addCommentView)
    }
    
    private func setupCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        let width = self.view.frame.size.width
        let headerHeight = self.view.frame.size.height * 0.2
        
        flowLayout.estimatedItemSize = CGSize(width: width, height: headerHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        flowLayout.headerReferenceSize = CGSize(width: view.frame.width, height: headerHeight)
        
        collectionView.collectionViewLayout = flowLayout
    }
}

// MARK: - UICollectionViewDataSource implementation

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueDetailViewModel.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: IssueDetailCellView = collectionView.dequeueCell(at: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: issueDetailViewModel.comments[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header: IssueDetailHeaderView = collectionView.dequeueHeader(at: indexPath) else { return UICollectionReusableView() }
        
        header.configure(with: issueDetailViewModel)
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension IssueDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        
        if let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? IssueDetailHeaderView {
            
            let size = CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height)
            return headerView.systemLayoutSizeFitting(size, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        }
        
        return CGSize(width: self.view.frame.width, height: CGFloat(100))
    }
    
}

extension IssueDetailViewController {
    static let nibName = "IssueDetailViewController"
    
    static func createViewController(issueDetailViewModel: IssueDetailViewModel) -> IssueDetailViewController {
        let vc = IssueDetailViewController(issueDetailViewModel: issueDetailViewModel)
        return vc
    }
}

extension IssueDetailViewController: AddCommentDelegate {
    func upButtonTapped() {
        guard let currentIndexPath = self.currentIndexPath else { return }
        
        if currentIndexPath.item == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.contentOffset = CGPoint.zero
            })
        } else if currentIndexPath.item != -1 {
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndexPath.item - 1, section: 0), at: .top, animated: true)
        }
    }
    
    func downButtonTapped() {
        guard let currentIndexPath = self.currentIndexPath else { return }
        
        if currentIndexPath.item < self.issueDetailViewModel.comments.count - 1 {
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndexPath.item + 1, section: 0), at: .top, animated: true)
        }
    }
    
    func addCommentButtonTapped() {
        AddNewIssueViewController.present(at: self, addType: .newComment, onDismiss: { [weak self] (content) in
            print(content)
            self?.issueDetailViewModel.addComment(content: content)
        })
    }
}
