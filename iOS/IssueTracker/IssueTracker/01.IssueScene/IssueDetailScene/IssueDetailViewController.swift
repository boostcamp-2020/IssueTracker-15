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
    private var cellData = [
        "레이블 전체 목록을 볼 수 있는게 어떨까요 전체 설명이 보여야 선택할 수 있으니까 마크다운 문법을 지원하고 HTML 형태로 보여줘야 할까요",
        "긍정적인 기능이네요 댓글은 한 줄",
        "아 힘드렁",
        "Where does it come from? Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var addCommentView: AddCommentView?
    private var issueDetailViewModel: IssueDetailViewModelProtocol?
    private var currentIssueId: Int = -1
    private var didFetchDetails: Bool = false
    
    private var currentIndexPath: IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.minY)
        if let currentIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            return currentIndexPath
        } else {
            return IndexPath(item: -1, section: 0)
        }
    }
    
    init(currentIssueId: Int, issueDetailViewModel: IssueDetailViewModelProtocol) {
        self.currentIssueId = currentIssueId
        self.issueDetailViewModel = issueDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        configureNavigationBarButtons()
        configureIssueDetailViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        configureInitialLayout()
    }
    
    private func configureNavigationBarButtons() {
        configureBackButton()
        configureEditButton()
    }
    
    private func configureIssueDetailViewModel() {
        issueDetailViewModel?.didFetch = { [weak self] in
            self?.didFetchDetails = true
        }
    }
    
    private func configureBackButton() {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(self.backButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureEditButton() {
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
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
        self.tabBarController?.tabBar.isHidden = true
        addCommentView = AddCommentView.createView()
        let height = view.frame.height
        let width  = view.frame.width
        self.addCommentView?.frame = CGRect(x: 0, y: self.view.frame.maxY * 0.85, width: width, height: height)
    }
    
    private func addBottomSheetView() {
        guard let addCommentView = addCommentView else { return }
        
        addCommentView.upButtonTapped = { [weak self] in
            guard let `self` = self,
                let currentIndexPath = self.currentIndexPath
                else { return }
            
            if currentIndexPath.item == 0 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.collectionView.contentOffset = CGPoint.zero
                })
            } else if currentIndexPath.item != -1 {
                self.collectionView.scrollToItem(at: IndexPath(item: currentIndexPath.item - 1, section: 0), at: .top, animated: true)
            }
        }
        
        addCommentView.downButtonTapped = { [weak self] in
            guard let `self` = self,
                let currentIndexPath = self.currentIndexPath,
                currentIndexPath.item < self.cellData.count - 1
                else { return }
            
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndexPath.item + 1, section: 0), at: .top, animated: true)
        }
        
        self.view.addSubview(addCommentView)
    }
    
    private func setupCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        let width = self.view.frame.size.width
        let headerHeight = self.view.frame.size.height * 0.2
        
        flowLayout.estimatedItemSize = CGSize(width: width, height: headerHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = flowLayout
    }
}

// MARK: - UICollectionViewDataSource implementation

extension IssueDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: IssueDetailCellView = collectionView.dequeueCell(at: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: cellData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header: IssueDetailHeaderView = collectionView.dequeueHeader(at: indexPath),
            let issueDetailViewModel = issueDetailViewModel
            else { return UICollectionReusableView() }
        
        if didFetchDetails {
            header.configure(with: issueDetailViewModel)
        } else {
            issueDetailViewModel.needFetchDetails()
            header.configure(with: issueDetailViewModel)
        }
        
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
            headerView.layoutIfNeeded()
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
            return CGSize(width: self.view.frame.width, height: height)
        }

        return CGSize(width: self.view.frame.width, height: CGFloat(100))
    }

}

extension IssueDetailViewController {
    static let nibName = "IssueDetailViewController"
    
    static func createViewController(currentIssueId: Int, issueDetailViewModel: IssueDetailViewModel) -> IssueDetailViewController {
        let vc = IssueDetailViewController(currentIssueId: currentIssueId, issueDetailViewModel: issueDetailViewModel)
        return vc
    }
}
